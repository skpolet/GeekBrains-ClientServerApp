//
//  VKService.swift
//  GeekBrains-ClientServerApp
//
//  Created by Sergey Mikhailov on 13/05/2019.
//  Copyright © 2019 Sergey Mikhailov. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class VKService: NSObject {

    
    func getGroupsWithString(name :String, completion: @escaping (_ result: GroupList)->()){
        let session = Session.instance
        Alamofire.request("https://api.vk.com/method/groups.search?user_id=\(session.userId)&access_token=\(session.token)&q=\(name)&v=5.68").responseJSON { (response) in
            print("GroupSearch :\(response)")
        }
    }
    
    func getGroups(completion: @escaping (_ result: GroupList)->()){
        let session = Session.instance
        //        Alamofire.request("https://api.vk.com/method/groups.get?user_id=\(session.userId)&access_token=\(session.token)&extended=1&count=5&v=5.68").responseJSON { (response) in
        let URL = "https://api.vk.com/method/groups.get?user_id=\(session.userId)&access_token=\(session.token)&extended=1&count=5&v=5.68"
        Alamofire.request(URL).responseObject { (response: DataResponse<ResponseGroups>) in
            //print("groupsList :\(response)")
            let responseObject = response.result.value
            //print("groupList : \(String(describing: response.result.value))")
            print("groupsList : \(String(describing: responseObject?.response)) and: \(URL)")
            
            if let groupList = responseObject?.response {
                completion(groupList)
                if let groups = groupList.items{
                    for group in groups{
                        print("groups: \(String(describing: group.name))")
                    }
                }
            }
        }
    }
    
    func getFriends(completion: @escaping (_ result: FriendList)->()){
        let session = Session.instance
        
        let URL = "https://api.vk.com/method/friends.get?user_id=\(session.userId)&access_token=\(session.token)&order=name&fields=city,domain&name_case=ins&count=5&fields=photo_50&v=5.68"
        
        Alamofire.request(URL).responseObject { (response: DataResponse<ResponseFriends>) in
            
            let responseObject = response.result.value
            print("friendList : \(String(describing: responseObject?.response)) and: \(URL)")
            
            if let friendList = responseObject?.response {
                completion(friendList)
                if let friends = friendList.items{
                    for friend in friends{
                        print("friend: \(String(describing: friend.name))")
                    }
                }
            }
        }
    }
    
    func getUserWithID(user_id :String ,completion: @escaping (_ result: User)->()){
        let session = Session.instance
        
        let URL = "https://api.vk.com/method/users.get?user_ids=\(user_id)&fields=bdate&access_token=\(session.token)&v=5.95"
        
        Alamofire.request(URL).responseObject { (response: DataResponse<ResponseUser>) in
            
            if let responseObject = response.result.value{
                print("userInfo : \(String(describing: responseObject.response?[0].name)) and: \(URL)")
                let userDefaults = UserDefaults.standard
                userDefaults.set(responseObject.response?[0].name, forKey: "userName")
                print("fromUserDefaults:\(String(describing: userDefaults.string(forKey: "userName")))")
            }

        }
    }
}
