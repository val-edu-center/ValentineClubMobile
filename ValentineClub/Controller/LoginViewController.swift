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
    //First field can be used for first name or username
    @IBOutlet weak var firstField: UITextField!
    @IBOutlet weak var firstLabel: UILabel!
    //Second field can be used for last name or password
    @IBOutlet weak var secondField: UITextField!
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var logoDarkView: UIImageView!
    @IBOutlet weak var logoLightView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if traitCollection.userInterfaceStyle == .light {
            logoLightView.isHidden = false
            logoDarkView.isHidden = true
        } else {
            logoLightView.isHidden = true
            logoDarkView.isHidden = false
        }
        
        self.firstField.delegate = self
        self.secondField.delegate = self
        
        self.hideKeyboardWhenTappedAround()
        //Looks for single or multiple taps.
//         let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
    }
//    //Calls this function when the tap is recognized.
//    @objc func dismissKeyboard() {
//        //Causes the view (or one of its embedded text fields) to resign the first responder status.
//        view.endEditing(true)
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //textField code
        textField.resignFirstResponder()  //if desired
        signIn()
        return true
    }
    
    @IBAction func onRoleSegmentChange(_ sender: Any) {
        let role = roleSegment.titleForSegment(at: roleSegment.selectedSegmentIndex)
        if (role!.elementsEqual("Cadet") || role!.elementsEqual("Prep")) {
            firstLabel.text = "First Name"
            secondLabel.text = "Last Name"
            secondField.isSecureTextEntry = false
        } else {
            firstLabel.text = "Username"
            secondLabel.text = "Password"
            secondField.isSecureTextEntry = true
        }
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        signIn()
    }
    
    private func signIn() {
        let role = roleSegment.titleForSegment(at: roleSegment.selectedSegmentIndex)
        
        if (role!.elementsEqual("Cadet") || role!.elementsEqual("Prep")) {
            let firstName = firstField.text!.components(separatedBy: .whitespaces).joined()
            let lastName = secondField.text!.components(separatedBy: .whitespaces).joined()
      
            let username = CredentialService.getUsername(firstName: firstName, lastName: lastName, role: role!)
            let password = CredentialService.getPassword(firstName: firstName, lastName: lastName, role: role!)
            
            PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
                if (user != nil) {
                    self.firstField.text = ""
                    self.secondField.text = ""
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                } else {
                    ErrorMessenger.showErrorMessage(action: "Sign in", error: error, view: self.view)
                }
            }
        } else {
            let username = firstField.text!
            let password = secondField.text!
            
            PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
                if (user != nil) {
                    self.firstField.text = ""
                    self.secondField.text = ""
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                } else {
                    ErrorMessenger.showErrorMessage(action: "Sign in", error: error, view: self.view)
                }
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let role = roleSegment.titleForSegment(at: roleSegment.selectedSegmentIndex)
        let user = PFUser()
        user.username = firstField.text
        user.password = secondField.text
    
        if (role!.elementsEqual("Cadet") || role!.elementsEqual("Prep")) {
            let firstName = firstField.text!.components(separatedBy: .whitespaces).joined()
            let lastName = secondField.text!.components(separatedBy: .whitespaces).joined()
      
            user.username = CredentialService.getUsername(firstName: firstName, lastName: lastName, role: role!)
            user.password = CredentialService.getPassword(firstName: firstName, lastName: lastName, role: role!)
        }
        
        user.setValue([role], forKey: "roles")
        user.setValue(false, forKey: "isApproved")
        
        let acl = PFACL()
        if (!(role?.elementsEqual("Staff"))!) {
            acl.setWriteAccess(true, forRoleWithName:"Staff")
            acl.setReadAccess(true, forRoleWithName:"Club")
            acl.setReadAccess(true, forRoleWithName: role!)
        }
        acl.setReadAccess(true, forRoleWithName:"Staff")
        acl.setReadAccess(true, forRoleWithName:"Director")
        acl.setWriteAccess(true, forRoleWithName:"Director")
        user.acl = acl

        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                ErrorMessenger.showErrorMessage(action: "Sign up", error: error, view: self.view)
            }
        }
        
    }

}
