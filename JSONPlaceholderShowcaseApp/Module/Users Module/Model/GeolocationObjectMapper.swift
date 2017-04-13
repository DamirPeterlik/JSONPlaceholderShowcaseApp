//
//  GeolocationObjectMapper.swift
//  JSONPlaceholderShowcaseApp
//
//  Created by Damir Peterlik on 12/04/2017.
//  Copyright © 2017 Damir Peterlik. All rights reserved.
//

import ObjectMapper

struct GeolocationObjectMapper: Mappable {
    var latitude: String?
    var longitude: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        latitude <- map["lat"]
        longitude <- map["lng"]
    }
    
}
