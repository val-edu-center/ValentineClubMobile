//
//  TransactionTableViewController.swift
//  Valentine Club App
//
//  Created by Valentine Education Center on 12/17/21.
//

import UIKit
import Parse

var transactions: [PFObject] = [PFObject]()
var currentUsername = ""

class TransactionTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        currentUsername = PFUser.current()!.username!
        let usernameQuery = PFQuery(className:"Transactions")
        usernameQuery.whereKey("username", equalTo: currentUsername)

        let targetUsernameQuery = PFQuery(className:"Transactions")
        targetUsernameQuery.whereKey("targetUsername", equalTo: currentUsername)

        let query = PFQuery.orQuery(withSubqueries: [usernameQuery, targetUsernameQuery])
        
        do {
            try transactions = query.findObjects().filter({ transaction in
                let targetUsername = transaction["targetUsername"] as? String
                let transactionType = transaction["transactionType"] as! String
                let isCurrentUserTarget = targetUsername?.elementsEqual(currentUsername) ?? false
                let isTransactionTypeSend = TransactionType(rawValue: transactionType) == TransactionType.Send
                
                return isTransactionTypeSend || isCurrentUserTarget
            })
        } catch {
            print("Transaction retrival error: \(error.localizedDescription)")
        }
    }

}

extension  TransactionTableViewController {
    
    static let transactionCellIdentifier = "TransactionCell"
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        createTransactionCell(indexPath: indexPath, transaction: transactions[indexPath.row])
    }
    
    private func createTransactionCell(indexPath: IndexPath, transaction: PFObject) -> TransactionCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.transactionCellIdentifier, for: indexPath) as? TransactionCell else {
                fatalError("Unable to dequeue TransactionCell")
            }
        let amount = transaction["amount"] as! Int
        let targetUsername = transaction["targetUsername"] as? String
        let transactionType = transaction["transactionType"] as! String
        let username = transaction["username"] as! String
        
        switch TransactionType(rawValue: transactionType) {
            case .Send:
                if (username.elementsEqual(currentUsername)) {
                    cell.amountLabel.textColor = UIColor.systemRed
                    cell.amountLabel.text = "- $" + amount.description
                    cell.descriptionLabel.text = "Sent to " + targetUsername!
                } else {
                    cell.amountLabel.textColor = UIColor.systemGreen
                    cell.amountLabel.text = "+ $" + amount.description
                    cell.descriptionLabel.text = "Sent from " + username
                }
            case .Withdraw:
                cell.amountLabel.textColor = UIColor.systemRed
                cell.amountLabel.text = "- $" + amount.description
                if (username.elementsEqual(currentUsername)) {
                    cell.descriptionLabel.text = "Withdrawal"
                } else {
                    cell.descriptionLabel.text = "Withdrawal by " + username
                }
            default:
                cell.amountLabel.text = amount.description
                cell.descriptionLabel.text = "Unsure how to describe"
        }
        
        return cell
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let transaction = transactions[indexPath.row]
        
        let transactionDetailsViewController = segue.destination as! TransactionDetailsViewController
        transactionDetailsViewController.transaction = transaction
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
