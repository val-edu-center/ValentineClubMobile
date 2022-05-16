//
//  RoleMapper.swift
//  ValentineClub
//
//  Created by Valentine Education Center on 1/23/22.
//

import Foundation
import Parse


struct RoleMapper {
    
    static func getCurrentGroupRole() -> Role? {
        return getGroupRole(user: PFUser.current())
    }
    static func getRoles(user: PFUser?) -> [String]? {
        return user?["roles"] as? [String]
    }
    //TODO make this similar to front end logic
    //Make this return non null when adding guest role
    static func getGroupRole(user: PFUser?) -> Role? {
        let roles = getRoles(user: user) ?? []
        var groupRole: Role? = nil
        
        if (roles.contains(Role.Director.rawValue)) {
            groupRole = Role.Director
        } else if (roles.contains(Role.Director.rawValue)) {
            groupRole = Role.Staff
        } else if (roles.contains(Role.Staff.rawValue)) {
            groupRole = Role.Staff
        } else if (roles.contains(Role.Teen.rawValue)) {
            groupRole = Role.Teen
        } else if (roles.contains(Role.Intermediate.rawValue)) {
            groupRole = Role.Intermediate
        } else if (roles.contains(Role.Junior.rawValue)) {
            groupRole = Role.Junior
        } else if (roles.contains(Role.Prep.rawValue)) {
            groupRole = Role.Prep
        } else if (roles.contains(Role.Cadet.rawValue)) {
            groupRole = Role.Cadet
        } else if (roles.contains(Role.Club.rawValue)) {
            groupRole = Role.Club
        }
                    
        return groupRole
    }
}
