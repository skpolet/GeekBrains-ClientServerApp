//
//  ResponseFriends.swift
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

/// Maps object of Realm's List type
func <- <T: Mappable>(left: List<T>, right: Map)
{
    var array: [T]?
    
    if right.mappingType == .toJSON {
        array = Array(left)
    }
    
    array <- right
    
    if right.mappingType == .fromJSON {
        if let theArray = array {
            left.append(objectsIn: theArray)
        }
    }
}

class ResponseFriends: Object, Mappable {
    //var response: FriendList?
    var response = List<FriendList>()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        response <- map["response"]
    }
}
