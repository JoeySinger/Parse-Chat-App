//
//  ViewController.swift
//  ParseTest
//
//  Created by Joey Singer on 2/23/17.
//  Copyright © 2017 Joey Singer. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBAction func signUpActionButton(_ sender: UIButton) {
        myMethod()
    }
    @IBAction func loginActionButton(_ sender: UIButton) {
        PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!, block: { (user, error) in
            if let error = error {
                print(error)
                let errorAlert = UIAlertController(title: "Error", message: "Email/Password were incorrect. Please try again.", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                errorAlert.addAction(cancel)
                
            } else {
                //let destination = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "ChatBro")
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "ChatBro")
                self.show(vc as! UIViewController, sender: vc)
            }
        })
    }
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func myMethod() {
        let user = PFUser()
        user.password = passwordTextField.text
        user.email = emailTextField.text
        user.username = emailTextField.text
        // other fields can be set just like with PFObject
        
        user.signUpInBackground() {
            (succeeded: Bool, error: Error?) -> Void in
            if error != nil {
                //let errorAlert = UIAlertController(title: "Error", message: "Issue signing up. Please try again.", preferredStyle: .alert)
                
                //let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                //let errorString = error.userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
            } else {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "ChatBro")
                self.show(vc as! UIViewController, sender: vc)
                // Hooray! Let them use the app now.
            }
        }
        
    }


}

