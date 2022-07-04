//
//  Toaster.swift
//  ValentineClub
//
//  Created by Valentine Education Center on 7/4/22.
//

import Foundation
import Toast_Swift

struct Toaster {
    
    private static var style = ToastStyle()
    
    static func showToast(action: String, view: UIView) {
        let message =  "\(action) success"
        
        // create a new style

        // this is just one of many style options
        style.backgroundColor = .green

        // present the toast with the new style
        view.makeToast(message, duration: 1.5, position: .center, style: style)
        
    }
}
