//
//  TransactionTableViewController.swift
//  Valentine Club App
//
//  Created by Valentine Education Center on 12/17/21.
//

import UIKit

class TransactionTableViewController: UITableViewController {


}

extension  TransactionTableViewController {
    
    static let transactionCellIdentifier = "TransactionCell"
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.transactionCellIdentifier, for: indexPath) as? TransactionCell else {
                fatalError("Unable to dequeue TransactionCell")
            }
        if (indexPath.row % 2 == 0) {
            let amount = indexPath.row * 100
            cell.amountLabel.textColor = UIColor.systemGreen
            cell.amountLabel.text = "+ $" + amount.description
            cell.descriptionLabel.text = "YeetYeetYeetYeetYeetYeetYeetYeet"
        } else {
            let amount = indexPath.row * 100
            cell.amountLabel.textColor = UIColor.systemRed
            cell.amountLabel.text = "- $" + amount.description
            cell.descriptionLabel.text = "YeetYeetYeet"
        }
            return cell
        }
}
