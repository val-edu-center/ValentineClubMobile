//
//  WithdrawViewController.swift
//  Valentine Club App
//
//  Created by Valentine Education Center on 12/17/21.
//

import UIKit

class WithdrawViewController: UIViewController {
    
    
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBAction func addOne(_ sender: Any) {
        let newAmount = Int(amountLabel.text!)! + 1
        amountLabel.text = newAmount.description

    }
    
    @IBAction func subtractOne(_ sender: Any) {
        let newAmount = Int(amountLabel.text!)! - 1
        amountLabel.text = newAmount.description
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
