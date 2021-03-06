//
//  ErrorMessenger.swift
//  ValentineClub
//
//  Created by Valentine Education Center on 3/8/22.
//

import Foundation
import Toast_Swift

struct ErrorMessenger {
    
    private static var style = ToastStyle()
    
    static func showErrorMessageString(action: String, error: String?, view: UIView) {
        let message = error != nil ? "\(action) error: \(error!)" : "\(action) error"
        
        // create a new style

        // this is just one of many style options
        style.backgroundColor = .red

        // present the toast with the new style
        view.makeToast(message, duration: 1.5, position: .center, style: style)
        
    }
    
    static func showErrorMessage(action: String, error: Error?, view: UIView){
        let message = error != nil ? "\(action) error: \(error!.localizedDescription)" : "\(action) error"
        
        // create a new style

        // this is just one of many style options
        style.backgroundColor = .red

        // present the toast with the new style
        view.makeToast(message, duration: 1.5, position: .center, style: style)
    }
}
