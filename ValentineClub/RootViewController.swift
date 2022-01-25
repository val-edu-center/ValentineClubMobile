//
//  RootViewController.swift
//  ValentineClub
//
//  Created by Valentine Education Center on 1/22/22.
//

import UIKit
import Parse

class RootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let groupRole = RoleMapper.getCurrentGroupRole()
        
        // Do any additional setup after loading the view.
        let homeView = storyboard?.instantiateViewController(withIdentifier: "homeView") as! HomeViewController
        homeView.title = "Home"
        
        let bankView = storyboard?.instantiateViewController(withIdentifier: "bankView") as! BankViewController
        bankView.title = "V Bux"
        
        let groupRoleView = storyboard?.instantiateViewController(withIdentifier: "groupRoleView") as! GroupRoleViewController
        groupRoleView.title = groupRole ?? "Guest"
        groupRoleView.role = groupRole
        
        setViewControllers([homeView, bankView, groupRoleView], animated: true)
        
        guard let items = self.tabBar.items else { return }
        
        let images = ["house", "dollarsign.circle", "person"]
        
        for x in 0...(images.count-1) {
            items[x].image = UIImage(systemName: images[x])
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
