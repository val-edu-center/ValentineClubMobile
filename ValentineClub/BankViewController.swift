//
//  BankViewController.swift
//  Valentine Club App
//
//  Created by Valentine Education Center on 12/25/21.
//

import UIKit
import Parse

class BankViewController: UIViewController {

    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var sendMoneyButton: UIButton!
    @IBOutlet weak var withdrawButton: UIButton!
    @IBOutlet weak var transactionsButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    private var accountBalance: Int? = nil
    private var userAccount: PFObject? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        let contentWidth = scrollView.bounds.width
        let contentHeight = scrollView.bounds.height
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        loadAccountBalance()
    }
    
    @IBAction func payNow(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "transactionView") as! TransactionViewController
        vc.transactionType = "Send"
        vc.transactionMultiplier = "-"
        vc.previousAccountBalance = accountBalance
        vc.userAccount = userAccount
        vc.bankController = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func withdraw(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "transactionView") as! TransactionViewController
        vc.transactionType = "Withdraw"
        vc.transactionMultiplier = "-"
        vc.previousAccountBalance = accountBalance
        vc.userAccount = userAccount
        vc.bankController = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc func refresh() {
        loadAccountBalance()
        DispatchQueue.main.async {
           self.scrollView.refreshControl?.endRefreshing()
        }
    }
    
    private func loadAccountBalance() {
        let currentUser = PFUser.current()
        if currentUser != nil {
            let query = PFQuery(className:"Accounts")
            query.whereKey("username", equalTo: currentUser!.username!)
            query.getFirstObjectInBackground { account, error in
                if (account != nil) {
                    self.accountBalance = account!["balance"] as! Int
                    self.userAccount = account
                } else if (error != nil){
                    print("Account retrieval error: \(error?.localizedDescription)")
                }
                
                if (self.accountBalance != nil) {
                    self.balanceLabel.text = "$ " + self.accountBalance!.description
                    self.sendMoneyButton.isEnabled = true
                    self.withdrawButton.isEnabled = true
                    self.transactionsButton.isEnabled = true
                } else {
                    self.balanceLabel.text = "N/A"
                    self.alertLabel.text = "See front desk for account creation"
                }
            }
        } else {
            print("Account retrieval error: User not logged in")
        }
    }

}
