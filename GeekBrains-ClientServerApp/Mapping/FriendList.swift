//
//  FriendList.swift
//  GeekBrains-ClientServerApp
//
//  Created by Sergey Mikhailov on 13/05/2019.
//  Copyright © 2019 Sergey Mikhailov. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper


class FriendList: Mappable {
    var count: String?
    var items: [Friend]?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        let mapItems = map["response"]
        count <- mapItems["count"]
        items <- mapItems["items"]
        print("mapItems: \(mapItems), items :\(String(describing: items))")
    }
}
