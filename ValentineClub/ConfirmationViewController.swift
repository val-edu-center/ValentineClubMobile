//
//  ConfirmationViewController.swift
//  ValentineClub
//
//  Created by Valentine Education Center on 1/5/22.
//

import UIKit
import Parse

class ConfirmationViewController: UIViewController {
    
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var transactionType: TransactionType!
    var previousAccountBalance: Int!
    var userAccount: PFObject!
    var bankController: BankViewController!
    var amount: Int!
    var newAccountBalance: Int!
    var selectedUser: String?
    var selectedUserAccount: PFObject?
    
    var isCurrentUserTarget = false

    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUsername = PFUser.current()!.username!
        isCurrentUserTarget = selectedUser?.elementsEqual(currentUsername) ?? false
        
        switch transactionType {
            case .Send:
                promptLabel.text = "Confirm Amount to Send to " + selectedUser!
            case .Withdraw:
                if (isCurrentUserTarget) {
                    promptLabel.text = "Confirm Amount to Withdraw"
                } else {
                    promptLabel.text = "Confirm Amount to Withdraw from " + selectedUser!
                }
            default:
                print("Error: Not a valid transaction type")
        }
        if (isCurrentUserTarget || transactionType == TransactionType.Send) {
            amountLabel.text = "New Account Balance: $" + newAccountBalance.description
        } else {
            let oldTargetAccountBalance = selectedUserAccount!["balance"] as! Int
            let newTargetAccountBalance = oldTargetAccountBalance - amount
            amountLabel.text = "New Account Balance for " + selectedUser! + ": $" + newTargetAccountBalance.description
        }
    }
    
    @IBAction func submit(_ sender: Any) {
        createTransaction()
        if (transactionType != TransactionType.Withdraw || isCurrentUserTarget) {
            updateAccount()
            bankController.balanceLabel.text = "$ " + newAccountBalance.description
            bankController.setAccountBalance(balance: newAccountBalance)
        }
        if (selectedUserAccount != nil) {
            updateTargetAccount()
        }
        bankController.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func createTransaction() {
        var parseObject = PFObject(className:"Transactions")

        parseObject["username"] = PFUser.current()!.username!
        parseObject["transactionType"] = transactionType.rawValue
        parseObject["amount"] = amount
        parseObject["description"] = descriptionField.text
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
        switch transactionType {
            case .Send:
                let oldTargetAccountBalance = selectedUserAccount!["balance"] as! Int
                let newTargetAccountBalance = oldTargetAccountBalance + amount
                selectedUserAccount!["balance"] = newTargetAccountBalance
            case .Withdraw:
                let oldTargetAccountBalance = selectedUserAccount!["balance"] as! Int
                let newTargetAccountBalance = oldTargetAccountBalance - amount
                selectedUserAccount!["balance"] = newTargetAccountBalance
            default:
               return
        }

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
    
    @IBAction func quickAdd1(_ sender: Any) {
        descriptionField.text = "Attendance"
    }
    
    @IBAction func quickAdd2(_ sender: Any) {
        descriptionField.text = "Good Behavior"
    }
    
    @IBAction func quickAdd3(_ sender: Any) {
        descriptionField.text = "3D Print"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
