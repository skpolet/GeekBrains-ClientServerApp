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
import ObjectMapper_Realm
import RealmSwift

class Friend: Object, Mappable {
//    var name: String?
//    var lastname: String?
//    var photo_50: String?
//    var online: String?
    
    @objc dynamic var name: String = ""
    @objc dynamic var lastname: String = ""
    @objc dynamic var photo_50: String = ""
    @objc dynamic var online: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["first_name"]
        lastname <- map["last_name"]
        photo_50 <- map["photo_50"]
        online <- map["online"]
    }
}
