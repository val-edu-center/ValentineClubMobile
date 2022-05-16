//
//  RadioButtonTableViewCell.swift
//  ValentineClub
//
//  Created by Valentine Education Center on 2/15/22.
//

import UIKit
class RadioButtonTableViewCell: UITableViewCell {
    // 1
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // 2
    private let checked = UIImage(named: "checked-radio")
    private let unchecked = UIImage(named: "unchecked-radio")
    // 3
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    // 4
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // 5
    public func configure(_ text: String) {
        titleLabel.text = text
    }
    // 6
    public func isSelected(_ selected: Bool) {
        setSelected(selected, animated: false)
        let image = selected ? checked : unchecked
        iconImage.image = image
    }
}
