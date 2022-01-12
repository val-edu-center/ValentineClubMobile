//
//  LoginViewController.swift
//  parstagram
//
//  Created by Education Center on 3/10/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var roleSegment: UISegmentedControl!
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.usernameField.delegate = self
        self.passwordField.delegate = self
        //Looks for single or multiple taps.
         let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        //textField code

        textField.resignFirstResponder()  //if desired
        signIn()
        return true
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        signIn()
    }
    
    private func signIn() {
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
        
        let acl = PFACL()
        if (!(role?.elementsEqual("Staff"))!) {
            acl.setReadAccess(true, forRoleWithName:"Staff")
            acl.setWriteAccess(true, forRoleWithName:"Staff")
        }
        acl.setReadAccess(true, forRoleWithName:"Director")
        acl.setWriteAccess(true, forRoleWithName:"Director")
        user.acl = acl

        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Sign up error: \(error?.localizedDescription)")
            }
        }
    }

}
