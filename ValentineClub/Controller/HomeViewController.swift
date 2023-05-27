//
//  HomeViewController.swift
//  ValentineClub
//
//  Created by Valentine Education Center on 1/19/22.
//

import UIKit
import Parse
import Toast_Swift

class HomeViewController: UIViewController {

    @IBOutlet weak var frontImage: UIImageView!
    
    var tapCounter: Int = 0
    override func viewDidLoad() {
        let imageCount = 6
        super.viewDidLoad()
        let randomInt = Int.random(in: 1..<(imageCount + 1))
        frontImage.image = UIImage(named: "Front" + randomInt.description)
    }

//        // Do any additional setup after loading the view.
//
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.imageTapped(gesture:)))
//
//                // add it to the image view;
//                frontImage.addGestureRecognizer(tapGesture)
//                // make sure imageView can be interacted with by user
//                frontImage.isUserInteractionEnabled = true
    
//    @objc func imageTapped(gesture: UIGestureRecognizer) {
//            // if the tapped view is a UIImageView then set it to imageview
//            if (gesture.view as? UIImageView) != nil {
//                if (tapCounter < 2) {
//                    tapCounter = tapCounter + 1
//                } else {
//                    PFUser.logOut()
//                    dismiss(animated: true, completion: nil)
//                }
//            }
//        }

}
