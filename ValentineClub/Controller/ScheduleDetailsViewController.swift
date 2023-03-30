//
//  ViewController.swift
//  ValentineClub
//
//  Created by Valentine Education Center on 3/30/23.
//

import UIKit
import Parse
import AlamofireImage

class ScheduleDetailsViewController: UIViewController {
    

    @IBOutlet weak var scheduleTitle: UILabel!
    @IBOutlet weak var scheduleImage: UIImageView!
    var scheduleTitleString: String = ""
    var scheduleImageUrl: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        scheduleTitle.text = scheduleTitleString
        scheduleImage.af.setImage(withURL: URL(string: scheduleImageUrl)!)
    }

}
