//
//  GroupRoleViewController.swift
//  ValentineClub
//
//  Created by Valentine Education Center on 1/23/22.
//

import UIKit

class GroupRoleViewController: UIViewController {
    
    public var role: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        switch role {
//        case.Member
//        }
        
        if (role.elementsEqual("Teen")) {
            self.view.backgroundColor = UIColor.blue
        } else if (role.elementsEqual("Member")) {
            self.view.backgroundColor = UIColor.red
        } else if (role.elementsEqual("Staff")) {
            self.view.backgroundColor = UIColor.green
        } else if (role.elementsEqual("Director")) {
            self.view.backgroundColor = UIColor.purple
        } else {
            self.view.backgroundColor = UIColor.systemPink
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
