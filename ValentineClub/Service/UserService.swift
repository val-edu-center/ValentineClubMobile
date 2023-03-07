
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
        let firstName = (user["firstName"] as? String ?? "").trimmingCharacters(in:.whitespacesAndNewlines)
        let lastName = (user["lastName"] as? String ?? "").trimmingCharacters(in:.whitespacesAndNewlines)
        let username = user.username!
        return (firstName == "" && lastName == "") ? username : firstName + " " + lastName
    }
}
