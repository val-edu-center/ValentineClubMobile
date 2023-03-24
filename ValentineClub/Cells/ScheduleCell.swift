//
//  ScheduleCell.swift
//  ValentineClub
//
//  Created by Valentine Education Center on 3/24/23.
//

import Foundation
import UIKit

class ScheduleCell: UITableViewCell {

    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

