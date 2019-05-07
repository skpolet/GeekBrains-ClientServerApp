//
//  FriendListController.swift
//  GeekBrains-ClientServerApp
//
//  Created by Sergey Mikhailov on 07/05/2019.
//  Copyright © 2019 Sergey Mikhailov. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class FriendListController: UIViewController {

    var friendListResponse:FriendList?
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getFriends()
    }
    

    func getFriends(){
        let session = Session.instance
       
       let URL = "https://api.vk.com/method/friends.get?user_id=\(session.userId)&access_token=\(session.token)&order=name&fields=city,domain&name_case=ins&count=5&fields=photo_50&v=5.68"

        Alamofire.request(URL).responseObject { (response: DataResponse<ResponseFriends>) in

            let responseObject = response.result.value
            print("friendList : \(String(describing: responseObject?.response)) and: \(URL)")
            
            if let friendList = responseObject?.response {
                self.friendListResponse = friendList
                self.tableView.reloadData()
                if let friends = friendList.items{
                    for friend in friends{
                        print("friend: \(String(describing: friend.name))")
                    }
                }
            }
        }
    }

}

extension FriendListController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let friends = friendListResponse?.items
        return friends?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: "friendCell"))!
        
        // set the text from the data model
        let friends = friendListResponse?.items
        let friend: Friend = (friends?[indexPath.row])!
        cell.textLabel?.text = friend.name
        cell.detailTextLabel?.text = friend.lastname
        let imgUrl = URL(string:friend.photo_50!)
        cell.imageView?.sd_setImage(with: imgUrl, placeholderImage: UIImage(named: "noimg"))
        
        return cell
    }
    
    
}

class ResponseFriends: Mappable {
    var response: FriendList?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        response <- map["response"]
    }
}

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
