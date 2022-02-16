//
//  GroupRoleViewController.swift
//  ValentineClub
//
//  Created by Valentine Education Center on 1/23/22.
//

import UIKit

class GroupRoleViewController: UIViewController {
    
    var role: Role?
    
    @IBOutlet weak var votingButton: UIButton!
    
    @IBOutlet weak var printingButton: UIButton!
    
    @IBOutlet weak var scheduleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (role != nil) {
            switch role! {
            case Role.Director:
                votingButton.isEnabled = true
                printingButton.isEnabled = true
                scheduleButton.isEnabled = true
            case Role.Staff:
                votingButton.isEnabled = true
                printingButton.isEnabled = true
                scheduleButton.isEnabled = true
            case Role.Teen:
                votingButton.isEnabled = true
                printingButton.isEnabled = true
                scheduleButton.isEnabled = true
            case Role.Intermediate:
                printingButton.isEnabled = true
                scheduleButton.isEnabled = true
            case Role.Junior:
                printingButton.isEnabled = true
                scheduleButton.isEnabled = true
            case Role.Prep:
                printingButton.isEnabled = true
                scheduleButton.isEnabled = true
            case Role.Cadet:
                printingButton.isEnabled = true
                scheduleButton.isEnabled = true
            default:
                self.view.backgroundColor = UIColor.orange
            }
            
        }

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func presentVotingView(_ sender: Any) {
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
