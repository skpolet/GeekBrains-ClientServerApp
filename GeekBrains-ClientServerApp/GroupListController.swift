//
//  GroupListController.swift
//  GeekBrains-ClientServerApp
//
//  Created by Sergey Mikhailov on 07/05/2019.
//  Copyright © 2019 Sergey Mikhailov. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import SDWebImage

class GroupListController: UIViewController {

    var groupListResponse:GroupList?
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        getGroups()
    }
    
    func getGroupsWithString(name :String){
        let session = Session.instance
        Alamofire.request("https://api.vk.com/method/groups.search?user_id=\(session.userId)&access_token=\(session.token)&q=\(name)&v=5.68").responseJSON { (response) in
            print("GroupSearch :\(response)")
        }
    }
    
    func getGroups(){
        let session = Session.instance
        //        Alamofire.request("https://api.vk.com/method/groups.get?user_id=\(session.userId)&access_token=\(session.token)&extended=1&count=5&v=5.68").responseJSON { (response) in
        let URL = "https://api.vk.com/method/groups.get?user_id=\(session.userId)&access_token=\(session.token)&extended=1&count=5&v=5.68"
        Alamofire.request(URL).responseObject { (response: DataResponse<ResponseGroups>) in
            //print("groupsList :\(response)")
            let responseObject = response.result.value
            //print("groupList : \(String(describing: response.result.value))")
            print("groupsList : \(String(describing: responseObject?.response)) and: \(URL)")
            
            if let groupList = responseObject?.response {
                self.groupListResponse = groupList
                self.tableView.reloadData()
                if let groups = groupList.items{
                    for group in groups{
                        print("groups: \(String(describing: group.name))")
                    }
                }
            }
        }
    }

}

extension GroupListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let groups = groupListResponse?.items
        return groups?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: "groupCell"))!
        
        // set the text from the data model
        let groups = groupListResponse?.items
        let group: Group = (groups?[indexPath.row])!
        cell.textLabel?.text = group.name
        cell.detailTextLabel?.text = group.type
        let imgUrl = URL(string:group.photo_100!)
        cell.imageView?.sd_setImage(with: imgUrl, placeholderImage: UIImage(named: "noimg"))
 
        
        return cell
    }
    
    
    
}

class GroupList: Mappable {
    var count: String?
    var items: [Group]?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        let mapItems = map["response"]
        count <- mapItems["count"]
        items <- mapItems["items"]
        print("mapItems: \(mapItems), items :\(String(describing: items))")
    }
}

class ResponseGroups: Mappable{
    var response: GroupList?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        response <- map["response"]
    }
}

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
