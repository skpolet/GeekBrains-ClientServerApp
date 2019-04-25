//
//  ViewController.swift
//  GeekBrains-ClientServerApp
//
//  Created by Sergey Mikhailov on 25/04/2019.
//  Copyright © 2019 Sergey Mikhailov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let session = Session.instance
        session.token = "token"
        session.userId = 1
        
    }
    
}

