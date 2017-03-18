//
//  Geolocation.swift
//  JSONPlaceholderShowcaseApp
//
//  Created by Damir Peterlik on 18/03/2017.
//  Copyright © 2017 Damir Peterlik. All rights reserved.
//

import Unbox

struct Geolocation {
    let latitude: Double
    let longitude: Double
}

extension Geolocation: Unboxable {
    init(unboxer: Unboxer) throws {
        self.latitude = try unboxer.unbox(key: "lat")
        self.longitude = try unboxer.unbox(key: "lng")
    }
}
