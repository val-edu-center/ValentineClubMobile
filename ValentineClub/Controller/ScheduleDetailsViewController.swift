//
//  ViewController.swift
//  ValentineClub
//
//  Created by Valentine Education Center on 3/30/23.
//

import UIKit
import Parse
import AlamofireImage

class ScheduleDetailsViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scheduleImage: UIImageView!
    
    var scheduleImageUrl: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.maximumZoomScale = 3.0
        scrollView.minimumZoomScale = 1.0
        
        scheduleImage.af.setImage(withURL: URL(string: scheduleImageUrl)!)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.scheduleImage
    }

}
