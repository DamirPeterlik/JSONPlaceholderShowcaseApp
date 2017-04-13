//
//  AddressObjectMapper.swift
//  JSONPlaceholderShowcaseApp
//
//  Created by Damir Peterlik on 12/04/2017.
//  Copyright © 2017 Damir Peterlik. All rights reserved.
//

import ObjectMapper

struct AddressObjectMapper: Mappable {
    var street: String?
    var suite: String?
    var city: String?
    var zipCode: String?
    var geolocation: GeolocationObjectMapper?
    
    init?(map: Map) {

    }
    
    mutating func mapping(map: Map) {
        street <- map["street"]
        suite <- map["suite"]
        city <- map["city"]
        zipCode <- map["zipcode"]
        geolocation <- map["geo"]
    }
    
}

