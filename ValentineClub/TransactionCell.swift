//
//  TransactionCell.swift
//  Valentine Club App
//
//  Created by Education Center on 11/20/21.
//

import UIKit

class TransactionCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
