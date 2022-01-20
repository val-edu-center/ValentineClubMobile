//
//  HomeViewController.swift
//  ValentineClub
//
//  Created by Valentine Education Center on 1/19/22.
//

import UIKit
import Parse

class HomeViewController: UIViewController {

    @IBOutlet weak var frontImage: UIImageView!
    
    var tapCounter: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.imageTapped(gesture:)))

                // add it to the image view;
                frontImage.addGestureRecognizer(tapGesture)
                // make sure imageView can be interacted with by user
                frontImage.isUserInteractionEnabled = true
    }
    
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
            // if the tapped view is a UIImageView then set it to imageview
            if (gesture.view as? UIImageView) != nil {
                if (tapCounter < 2) {
                    tapCounter = tapCounter + 1
                } else {
                    PFUser.logOut()
                    dismiss(animated: true, completion: nil)
                }
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
