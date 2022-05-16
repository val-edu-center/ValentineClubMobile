//
//  TransactionDetailsViewController.swift
//  ValentineClub
//
//  Created by Valentine Education Center on 3/16/22.
//

import UIKit
import Parse


class TransactionDetailsViewController: UIViewController {

    var transaction: PFObject!
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var otherAccountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let amount = transaction["amount"] as! Int
        let username = transaction["username"] as! String
        let transactionType = transaction["transactionType"] as! String
        let targetUsername = transaction["targetUsername"] as? String
        let description = transaction["description"] as? String
        let currentUsername = PFUser.current()!.username!
        
        if (description == nil || description?.trimmingCharacters(in: .whitespaces) == "") {
            descriptionLabel.text = "No description provided"
        } else {
            descriptionLabel.text = "Description: \(description!)"
        }
        
        switch TransactionType(rawValue: transactionType) {
            case .Send:
                if (username.elementsEqual(currentUsername)) {
                    amountLabel.textColor = UIColor.systemRed
                    amountLabel.text = "- $" + amount.description
                    otherAccountLabel.text = "Sent to " + targetUsername!
                } else {
                    amountLabel.textColor = UIColor.systemGreen
                    amountLabel.text = "+ $" + amount.description
                    otherAccountLabel.text = "Sent from " + username
                }
            case .Withdraw:
                amountLabel.textColor = UIColor.systemRed
                amountLabel.text = "- $" + amount.description
                if (username.elementsEqual(currentUsername)) {
                    otherAccountLabel.text = "Withdrawal"
                } else {
                    otherAccountLabel.text = "Withdrawal by " + username
                }
            default:
                amountLabel.text = amount.description
                otherAccountLabel.text = "Unsure how to describe"
        }
    }

}
