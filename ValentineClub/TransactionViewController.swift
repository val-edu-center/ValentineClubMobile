//
//  PayViewController.swift
//  Valentine Club App
//
//  Created by Valentine Education Center on 12/23/21.
//

import UIKit
import Parse

class TransactionViewController: UIViewController {
    
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    var transactionType: TransactionType!
    var previousAccountBalance: Int!
    var userAccount: PFObject!
    var bankController: BankViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.promptLabel.text = "Select Amount to " + transactionType.rawValue

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func subtractOne(_ sender: Any) {
        let newAmount = getAmountDifference( difference: -1)
        amountLabel.text = newAmount.description
    }

    @IBAction func addOne(_ sender: Any) {
        let newAmount = getAmountDifference( difference: 1)
        amountLabel.text = newAmount.description
    }
    
    @IBAction func submitTransaction(_ sender: Any) {
        if (getAmount() > 0 && getNewAccountBalance() >= 0) {
            switch transactionType {
                case .Send:
                    let vc = createUserSelect()
                    present(vc, animated: true, completion: nil)
                case .Withdraw:
                    let vc = createUserSelect()
                    present(vc, animated: true, completion: nil)
                default:
                    print("Error: Not a valid transaction type")
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func createConfirmation() -> ConfirmationViewController{
        let vc = storyboard?.instantiateViewController(withIdentifier: "confirmationView") as! ConfirmationViewController
        vc.transactionType = self.transactionType
        vc.newAccountBalance = self.getNewAccountBalance()
        vc.amount = getAmount()
        vc.userAccount = self.userAccount
        vc.bankController = self.bankController
        vc.modalPresentationStyle = .fullScreen
        
        return vc
    }
    
    private func createUserSelect() -> UserSelectViewController{
        let vc = storyboard?.instantiateViewController(withIdentifier: "userSelectView") as! UserSelectViewController
        vc.transactionType = self.transactionType
        vc.newAccountBalance = self.getNewAccountBalance()
        vc.amount = getAmount()
        vc.userAccount = self.userAccount
        vc.bankController = self.bankController
        vc.modalPresentationStyle = .fullScreen
        
        return vc
    }
    
    private func getAmount() -> Int {
        return getAmountDifference(difference: 0)
    }
    
    private func getAmountDifference(difference: Int) -> Int{
        let amount = Int(self.amountLabel.text!)! + difference
        if (amount < 0) {
            return 0
        } else {
            return amount
        }
    }
    
    
    private func getNewAccountBalance() -> Int {
        switch transactionType {
            case .Send:
                return previousAccountBalance - getAmount()
            case .Withdraw:
                return previousAccountBalance
            default:
               return previousAccountBalance
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
