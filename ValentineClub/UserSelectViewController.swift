//
//  UserSelectViewController.swift
//  Valentine Club App
//
//  Created by Valentine Education Center on 12/27/21.
//

import UIKit
import Parse

class UserSelectViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {

    @IBOutlet weak var userSelector: UIPickerView!
    
    var transactionType: TransactionType!
    var newAccountBalance: Int!
    var amount: Int!
    var userAccount: PFObject!
    var selectedUserAccount: PFUser!
    var selectedUser: String?
    var bankController: BankViewController!
    
    var pickerData: [PFUser] = [PFUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userSelector.delegate = self
        self.userSelector.dataSource = self
        
        currentUsername = PFUser.current()!.username!
        do {
            let users = try PFUser.query()!.findObjects() as! [PFUser]
            pickerData = users.filter({ user in
                !(user.username?.elementsEqual(currentUsername) ?? false) || transactionType == TransactionType.Withdraw
            })
            if (!pickerData.isEmpty) {
                selectedUser = pickerData[0].username
            }
        } catch {
            print("User retrieval error: \(error.localizedDescription)")
        }
            
        // Do any additional setup after loading the view.
    } // Number of columns of data
    
    @IBAction func submit(_ sender: Any) {
        let selectedUserAccount = AccountDao.getAccount(username: self.selectedUser!)
        let vc = storyboard?.instantiateViewController(withIdentifier: "confirmationView") as! ConfirmationViewController
        vc.transactionType = self.transactionType
        vc.newAccountBalance = self.newAccountBalance
        vc.amount = self.amount
        vc.selectedUser = self.selectedUser
        vc.selectedUserAccount = self.selectedUserAccount
        vc.userAccount = self.userAccount     
        vc.bankController = self.bankController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return UserService.getName(user: pickerData[row])
    }
    
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        selectedUser = pickerData[row].username
        selectedUserAccount = pickerData[row]
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
