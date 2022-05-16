//
//  CredentialService.swift
//  ValentineClub
//
//  Created by Valentine Education Center on 5/12/22.
//

import Foundation

struct CredentialService {
    static func getUsername(firstName: String, lastName: String, role: String) -> String {
        return "\(firstName.lowercased()).\(lastName.lowercased()).\(role.lowercased())"
    }
    static func getPassword(firstName: String, lastName: String, role: String) -> String {
        return "\(firstName.lowercased())!@!\(role.lowercased())#$#\(lastName.lowercased())"
    }
}
