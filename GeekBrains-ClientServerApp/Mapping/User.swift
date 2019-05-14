//
//  User.swift
//  GeekBrains-ClientServerApp
//
//  Created by Sergey Mikhailov on 14/05/2019.
//  Copyright © 2019 Sergey Mikhailov. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper


class User: Mappable {
    var name: String?
    var lastname: String?
    var iduser: String?
    var bdate: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        name <- map["first_name"]
        lastname <- map["last_name"]
        iduser <- map["id"]
        bdate <- map["bdate"]
    }
}
