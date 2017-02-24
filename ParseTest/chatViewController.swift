//
//  chatViewController.swift
//  ParseTest
//
//  Created by Joey Singer on 2/23/17.
//  Copyright © 2017 Joey Singer. All rights reserved.
//

import UIKit
import Parse

class chatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
   
    @IBAction func sendActionButton(_ sender: UIButton) {
        let post = PFObject(className: "Message")
        
        post["username"] = PFUser.current()!.username!
        post["message"] = messageText.text
        
        post.saveInBackground { (result, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.messageText.text = nil
            }
            self.messageText.isUserInteractionEnabled = true
        }
    }
    
    
    @IBOutlet weak var messageText: UITextField!
    
    var messages: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.isHidden = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(chatViewController.refresh), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh() {
        let query = PFQuery(className: "Message")
        query.order(byDescending: "createdAt")
        query.limit = 25
        query.findObjectsInBackground { (object, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let messages = object {
                self.messages = messages.reversed()
                self.tableView.reloadData()
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension chatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let message = messages[indexPath.row]
        var user = "n/a"
        var messageString = "n/a"
        if message["username"] != nil {
            user = message["username"] as! String
        }
        else {
        }
        if message["message"] != nil {
            messageString = message["message"] as! String
        }
        cell.textLabel?.text = "\(user): \(messageString)"
        
        if user == PFUser.current()!.username! {
            cell.textLabel?.textAlignment = .right
        }
    
        
        return cell
    }
}
