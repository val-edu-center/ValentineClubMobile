//
//  TransactionDetailsViewController.swift
//  ValentineClub
//
//  Created by Valentine Education Center on 3/16/22.
//

import UIKit
import Parse


class TransactionDetailsViewController: UIViewController {

    var transaction: PFObject!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let amount = transaction["amount"] as! Int
        amountLabel.text = amount.description
        
        
        
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
