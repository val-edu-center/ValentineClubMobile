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
    var dictionary: Dictionary<Role?, [PFUser]>?
    var availableRoles: [Role] = [Role]()
    var selectedRole: Role = Role.Cadet
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userSelector.delegate = self
        self.userSelector.dataSource = self
        
        selectedRole = RoleMapper.getGroupRole(user: PFUser.current()!) ?? Role.Cadet
        currentUsername = PFUser.current()!.username!
        do {
            let users = try PFUser.query()!.findObjects() as! [PFUser]
            pickerData = users.filter({ user in
                !(user.username?.elementsEqual(currentUsername) ?? false) || transactionType == TransactionType.Withdraw
            })
            dictionary = Dictionary(grouping: users, by: { RoleMapper.getGroupRole(user: $0) })
            for key in dictionary!.keys {
                if key != nil {
                    availableRoles.append(key!)
                }
            }
            if (!pickerData.isEmpty) {
                selectedUser = pickerData[0].username
                selectedUserAccount = pickerData[0]
            }
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
            return dictionary?[selectedRole]?.count ?? 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return availableRoles[row].rawValue
        } else {
            let users = dictionary?[selectedRole] ?? []
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
            selectedRole = availableRoles[row]
        } else {
            let users = dictionary?[selectedRole] ?? []
            if (!users.isEmpty) {
                selectedUser = users[row].username
                selectedUserAccount = users[row]
            }
        }
        
        userSelector.reloadComponent(1)
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
