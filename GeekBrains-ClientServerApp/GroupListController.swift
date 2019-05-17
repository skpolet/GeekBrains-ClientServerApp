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

        let vkService = VKService()
        vkService.getGroups { result in
            self.groupListResponse = result
            self.tableView.reloadData()
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





