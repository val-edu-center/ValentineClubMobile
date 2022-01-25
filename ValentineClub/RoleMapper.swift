//
//  RoleMapper.swift
//  ValentineClub
//
//  Created by Valentine Education Center on 1/23/22.
//

import Foundation
import Parse


struct RoleMapper {
    static func getCurrentGroupRole() -> String? {
        return getGroupRole(user: PFUser.current())
    }
    static func getRoles(user: PFUser?) -> [String]? {
        return user?["roles"] as? [String]
    }
    //TODO make this similar to front end logic
    static func getGroupRole(user: PFUser?) -> String? {
        return getRoles(user: user)?.first ?? nil
    }
}
