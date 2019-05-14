//
//  Friend.swift
//  GeekBrains-ClientServerApp
//
//  Created by Sergey Mikhailov on 13/05/2019.
//  Copyright © 2019 Sergey Mikhailov. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper


class Friend: Mappable {
    var name: String?
    var lastname: String?
    var photo_50: String?
    var online: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        name <- map["first_name"]
        lastname <- map["last_name"]
        photo_50 <- map["photo_50"]
        online <- map["online"]
    }
}
