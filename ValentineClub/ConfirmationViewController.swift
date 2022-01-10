//
//  ConfirmationViewController.swift
//  ValentineClub
//
//  Created by Valentine Education Center on 1/5/22.
//

import UIKit
import Parse

class ConfirmationViewController: UIViewController {
    
    @IBOutlet weak var promptLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    public var transactionType: String!
    public var transactionMultiplier: String!
    public var previousAccountBalance: Int!
    public var userAccount: PFObject!
    public var bankController: BankViewController!
    public var amount: Int!
    public var newAccountBalance: Int!
    public var selectedUser: String?
    public var selectedUserAccount: PFObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        if (transactionType.elementsEqual("Send")) {
            promptLabel.text = "Confirm Amount to Send to " + selectedUser!
        } else {
            promptLabel.text = "Confirm Amount to " + transactionType
        }
        amountLabel.text = "- $" + amount.description + "\nNew Account Balance: $" + newAccountBalance.description
    }
    
    @IBAction func submit(_ sender: Any) {
        createTransaction()
        updateAccount()
        if (selectedUserAccount != nil) {
            updateTargetAccount()
        }
        bankController.balanceLabel.text = "$ " + newAccountBalance.description
        bankController.setAccountBalance(balance: newAccountBalance)
        bankController.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func createTransaction() {
        var parseObject = PFObject(className:"Transactions")

        parseObject["username"] = PFUser.current()!.username!
        parseObject["transactionType"] = transactionType
        parseObject["amount"] = amount
        if (selectedUser != nil) {
            parseObject["targetUsername"] = selectedUser
        }

        // Saves the new object.
        parseObject.saveInBackground {
          (success: Bool, error: Error?) in
          if (success) {
            // The object has been saved.
          } else {
              print("Transaction creation error: \(error?.localizedDescription)")
          }
        }
    }
    
    private func updateAccount() {
        userAccount["balance"] = newAccountBalance

        // Saves the new object.
        userAccount.saveInBackground {
          (success: Bool, error: Error?) in
          if (success) {
            // The object has been saved.
          } else {
              print("Account update error: \(error?.localizedDescription)")
          }
        }
    }
    
    private func updateTargetAccount() {
        //Assumes we are sending
        let oldTargetAccountBalance = selectedUserAccount!["balance"] as! Int
        let newTargetAccountBalance = oldTargetAccountBalance + amount
        selectedUserAccount!["balance"] = newTargetAccountBalance


        // Saves the new object.
        selectedUserAccount!.saveInBackground {
          (success: Bool, error: Error?) in
          if (success) {
            // The object has been saved.
          } else {
              print("Account update error: \(error?.localizedDescription)")
          }
        }
    }
    
//    @IBAction func submit(_ sender: Any) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "confirmationView") as! ConfirmationViewController
//        vc.transactionType = self.transactionType
//        vc.transactionMultiplier = self.transactionMultiplier
//        vc.newAccountBalance = self.newAccountBalance
//        vc.amount = self.amount
//        vc.selectedUser = self.selectedUser
//        vc.userAccount = self.userAccount
//        vc.bankController = self.bankController
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true, completion: nil)
//    }
//
//    @IBAction func cancel(_ sender: Any) {

//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
