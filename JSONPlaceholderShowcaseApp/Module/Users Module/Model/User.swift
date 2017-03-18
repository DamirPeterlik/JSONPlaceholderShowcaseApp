//
//  User.swift
//  JSONPlaceholderShowcaseApp
//
//  Created by Damir Peterlik on 18/03/2017.
//  Copyright © 2017 Damir Peterlik. All rights reserved.
//

import Unbox

struct User {
    let ID: Int
    let name: String
    let username: String
    let phone: String
    let website: String
    let address: Address
}

extension User: Unboxable {
    init(unboxer: Unboxer) throws {
        self.ID = try unboxer.unbox(key: "id")
        self.name = try unboxer.unbox(key: "name")
        self.username = try unboxer.unbox(key: "username")
        self.phone = try unboxer.unbox(key: "phone")
        self.website = try unboxer.unbox(key: "website")
        self.address = try unboxer.unbox(key: "address")
    }
}
