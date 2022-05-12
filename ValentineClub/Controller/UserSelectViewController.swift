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
    var selectedRole: Role!
    
    var bankController: BankViewController!
    //TODO Make role non optional
    var pickerData = [Role? : [PFUser]]()
    var availableRoles = [Role]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userSelector.delegate = self
        self.userSelector.dataSource = self
        
        do {
            let currentUsername = PFUser.current()!.username!
            //TODO Put in Dao
            let usersRaw = try PFUser.query()!.findObjects() as! [PFUser]
            let users = usersRaw.filter({ user in
                !(user.username?.elementsEqual(currentUsername) ?? false) || transactionType == TransactionType.Withdraw
            })
            
            pickerData = Dictionary(grouping: users, by: { RoleMapper.getGroupRole(user: $0) })
            for key in pickerData.keys {
                if key != nil {
                    availableRoles.append(key!)
                }
            }
            
            selectRoleThenUser(roleIndex: 0, userIndex: 0)
            
        } catch {
            print("User retrieval error: \(error.localizedDescription)")
        }
            
        // Do any additional setup after loading the view.
    } // Number of columns of data
    
    @IBAction func submit(_ sender: Any) {
        let selectedUserBankAccount = AccountDao.getAccount(username: self.selectedUser!)
        let vc = storyboard?.instantiateViewController(withIdentifier: "confirmationView") as! ConfirmationViewController
        vc.transactionType = self.transactionType
        vc.newAccountBalance = self.newAccountBalance
        vc.amount = self.amount
        vc.selectedUser = self.selectedUser
        vc.selectedUserAccount = self.selectedUserAccount
        vc.selectedUserBankAccount = selectedUserBankAccount
        vc.userAccount = self.userAccount     
        vc.bankController = self.bankController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return availableRoles.count
        } else {
            return pickerData[selectedRole]?.count ?? 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return availableRoles[row].rawValue
        } else {
            let users = pickerData[selectedRole] ?? []
            if (users.isEmpty) {
                return nil
            } else {
                return UserService.getName(user: users[row])
            }
        }
    }
    
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        
        if component == 0 {
            selectRoleThenUser(roleIndex: row, userIndex: 0)
        } else {
            selectRoleThenUser(roleIndex: nil, userIndex: row)
        }
        
        userSelector.reloadComponent(1)
    }

    private func selectRoleThenUser(roleIndex: Int?, userIndex: Int) {
        if (!availableRoles.isEmpty && roleIndex != nil) {
            selectedRole = availableRoles[roleIndex!]
        }
        if (!pickerData.isEmpty) {
            let users = pickerData[selectedRole] ?? []
            if (!users.isEmpty) {
                selectedUser = users[userIndex].username
                selectedUserAccount = users[userIndex]
            }
        }
    }
}
