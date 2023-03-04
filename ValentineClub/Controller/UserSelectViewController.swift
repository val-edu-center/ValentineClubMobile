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
    var selectedRole: Role!
    
    var bankController: BankViewController!
    //TODO Make role non optional
    var groupsToUsers = [Role? : [PFUser]]()
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
            }).sorted( by: { compareUsers(user1: $0, user2: $1) })
            
            groupsToUsers = Dictionary(grouping: users, by: { RoleMapper.getGroupRole(user: $0) })
            for key in groupsToUsers.keys {
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
        let selectedUserBankAccount = AccountDao.getAccount(username: self.selectedUserAccount.username ?? "")
        let vc = storyboard?.instantiateViewController(withIdentifier: "confirmationView") as! ConfirmationViewController
        vc.transactionType = self.transactionType
        vc.newAccountBalance = self.newAccountBalance
        vc.amount = self.amount
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
            return groupsToUsers[selectedRole]?.count ?? 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return availableRoles[row].rawValue
        } else {
            let users = groupsToUsers[selectedRole] ?? []
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
        if (!groupsToUsers.isEmpty) {
            let users = groupsToUsers[selectedRole] ?? []
            if (!users.isEmpty) {
                selectedUserAccount = users[userIndex]
            }
        }
    }
    
    private func compareUsers(user1: PFUser, user2: PFUser) -> Bool{
        let userFullName1 = UserService.getName(user: user1).lowercased()
        let userFullName2 = UserService.getName(user: user2).lowercased()
        return userFullName1 < userFullName2
    }
}
