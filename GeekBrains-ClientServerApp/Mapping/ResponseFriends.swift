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


class ResponseFriends: Mappable {
    var response: FriendList?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        response <- map["response"]
    }
}
