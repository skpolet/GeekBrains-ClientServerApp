//
//  Group.swift
//  GeekBrains-ClientServerApp
//
//  Created by Sergey Mikhailov on 13/05/2019.
//  Copyright © 2019 Sergey Mikhailov. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper


class Group: Mappable {
    var name: String?
    var photo_100: String?
    var type: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        photo_100 <- map["photo_100"]
        type <- map["type"]
    }
}
