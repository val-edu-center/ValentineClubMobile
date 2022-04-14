//
//  UserService.swift
//  ValentineClub
//
//  Created by Valentine Education Center on 4/12/22.
//

import Foundation
import Parse

struct UserService {
    static func getName(user: PFUser) -> String {
        let name = user["firstName"] as? String
        let username = user.username!
        return name == nil ? username : name!
    }
}

