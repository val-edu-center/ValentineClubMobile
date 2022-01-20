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
    
    public var transactionType: TransactionType!
    public var previousAccountBalance: Int!
    public var userAccount: PFObject!
    public var bankController: BankViewController!
    public var amount: Int!
    public var newAccountBalance: Int!
    public var selectedUser: String?
    public var selectedUserAccount: PFObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUsername = PFUser.current()!.username!
        let isCurrentUserTarget = selectedUser?.elementsEqual(currentUsername) ?? false
        
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
            amountLabel.text = "- $" + amount.description + "\nNew Account Balance: $" + newAccountBalance.description
        } else {
            let oldTargetAccountBalance = selectedUserAccount!["balance"] as! Int
            let newTargetAccountBalance = oldTargetAccountBalance - amount
            amountLabel.text = "- $" + amount.description + "\nNew Account Balance for "
            + selectedUser! + ": $" + newTargetAccountBalance.description
        }
    }
    
    @IBAction func submit(_ sender: Any) {
        createTransaction()
        if (transactionType != TransactionType.Withdraw) {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
