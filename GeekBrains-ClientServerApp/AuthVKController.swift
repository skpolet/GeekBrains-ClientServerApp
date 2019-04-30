//
//  AuthVKController.swift
//  GeekBrains-ClientServerApp
//
//  Created by Sergey Mikhailov on 30/04/2019.
//  Copyright © 2019 Sergey Mikhailov. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class AuthVKController: UIViewController {

    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        authInVk()
    }
    func authInVk(){
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "6966370"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request)
    }
}

extension AuthVKController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        let token = params["access_token"]
        let userId = params["user_id"]
        let session = Session.instance
        session.token = token!
        session.userId = userId!

        getFriends()
        getGroups()
        getGroupsWithString(name: "ILIZIUM")
        
        decisionHandler(.cancel)
    }
    
    func getFriends(){
       let session = Session.instance
        Alamofire.request("https://api.vk.com/method/friends.get?user_id=\(session.userId)&access_token=\(session.token)&order=name&fields=city,domain&name_case=ins&count=5&fields=photo_50&v=5.68").responseJSON { (response) in
            print("friendList :\(response)")
        }
    }
    func getGroups(){
       let session = Session.instance
        Alamofire.request("https://api.vk.com/method/groups.get?user_id=\(session.userId)&access_token=\(session.token)&extended=1&count=5&v=5.68").responseJSON { (response) in
            print("groupsList :\(response)")
        }
    }
    func getGroupsWithString(name :String){
       let session = Session.instance
        Alamofire.request("https://api.vk.com/method/groups.search?user_id=\(session.userId)&access_token=\(session.token)&q=\(name)&v=5.68").responseJSON { (response) in
            print("GroupSearch :\(response)")
        }
    }
}
