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
        let vkService = VKService()
        vkService.getFriends { result in
            self.friendListResponse = result
            self.tableView.reloadData()
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

