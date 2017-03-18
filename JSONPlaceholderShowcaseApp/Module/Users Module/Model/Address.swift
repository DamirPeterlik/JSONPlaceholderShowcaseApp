//
//  Address.swift
//  JSONPlaceholderShowcaseApp
//
//  Created by Damir Peterlik on 18/03/2017.
//  Copyright © 2017 Damir Peterlik. All rights reserved.
//

import Unbox

struct Address {
    let street: String
    let suite: String
    let city: String
    let zipCode: String
    let geolocation: Geolocation
}

extension Address: Unboxable {
    init(unboxer: Unboxer) throws {
        self.street = try unboxer.unbox(key: "street")
        self.suite = try unboxer.unbox(key: "suite")
        self.city = try unboxer.unbox(key: "city")
        self.zipCode = try unboxer.unbox(key: "zipcode")
        self.geolocation = try unboxer.unbox(key: "geo")
    }
}
