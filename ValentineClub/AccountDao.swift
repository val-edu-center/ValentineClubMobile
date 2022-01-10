//
//  AccountDao.swift
//  ValentineClub
//
//  Created by Valentine Education Center on 1/9/22.
//

import Foundation
import Parse

struct AccountDao {
    static func getAccount(user: PFUser?) -> PFObject? {
        if (user != nil) {
            return getAccount(username: (user?.username)!)
        } else {
            return nil
        }
    }
    static func getAccount(username: String) -> PFObject? {
        let query = PFQuery(className:"Accounts")
        query.whereKey("username", equalTo: username)
        do {
            return try query.getFirstObject()
        } catch {
            print("Account retrival error: \(error.localizedDescription)")
            return nil
        }
    }
}
