//
//  GroupRoleViewController.swift
//  ValentineClub
//
//  Created by Valentine Education Center on 1/23/22.
//

import UIKit

class GroupRoleViewController: UIViewController {
    
    var role: Role?

    override func viewDidLoad() {
        super.viewDidLoad()
        if (role != nil) {
            switch role! {
            case Role.Director:
                self.view.backgroundColor = UIColor.purple
            case Role.Staff:
                self.view.backgroundColor = UIColor.green
            case Role.Teen:
                self.view.backgroundColor = UIColor.blue
            case Role.Intermediate:
                self.view.backgroundColor = UIColor.red
            case Role.Junior:
                self.view.backgroundColor = UIColor.red
            case Role.Prep:
                self.view.backgroundColor = UIColor.red
            case Role.Cadet:
                self.view.backgroundColor = UIColor.red
            default:
                self.view.backgroundColor = UIColor.orange
            }
            
        }

        // Do any additional setup after loading the view.
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
