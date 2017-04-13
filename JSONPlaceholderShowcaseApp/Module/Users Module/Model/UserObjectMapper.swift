//
//  UserObjectMapper.swift
//  JSONPlaceholderShowcaseApp
//
//  Created by Damir Peterlik on 12/04/2017.
//  Copyright © 2017 Damir Peterlik. All rights reserved.
//

import ObjectMapper

struct UserObjectMapper: Mappable {
    var ID: Int?
    var name: String?
    var username: String?
    var phone: String?
    var website: String?
    var address: AddressObjectMapper?
    
    init?(map: Map) {

    }
    
    mutating func mapping(map: Map) {
        ID <- map["id"]
        name <- map["name"]
        username <- map["username"]
        phone <- map["phone"]
        website <- map["website"]
        address <- map["address"]
    }
    
}
