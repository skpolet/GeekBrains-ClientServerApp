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
import AlamofireObjectMapper
import ObjectMapper
import SwiftKeychainWrapper

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
        
        guard let token = params["access_token"]
            else{
                return
        }
        guard let userId = params["user_id"]
            else{
                return
        }
        print("param: \(params)")
        let session = Session.instance
        KeychainWrapper.standard.set(token, forKey: "vkToken")
        session.userId = userId
        
        let vkService = VKService()
        vkService.getUserWithID(user_id: userId) { user in
            print("callbackUser:\(user)")
        }
        
        //getFriends()
        //getGroups()
        //getGroupsWithString(name: "ILIZIUM")
        self.performSegue(withIdentifier: "authSuccess", sender: self)
        decisionHandler(.cancel)
    }

}


