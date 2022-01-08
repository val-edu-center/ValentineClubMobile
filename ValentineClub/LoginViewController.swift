//
//  LoginViewController.swift
//  parstagram
//
//  Created by Education Center on 3/10/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var roleSegment: UISegmentedControl!
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!

        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if (user != nil) {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Sign in error: \(error?.localizedDescription)")
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let role = roleSegment.titleForSegment(at: roleSegment.selectedSegmentIndex)
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        user.setValue([role], forKey: "roles")
        user.setValue(false, forKey: "isApproved")

        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Sign up error: \(error?.localizedDescription)")
            }
        }
    }

}
