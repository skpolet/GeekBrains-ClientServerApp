//
//  Session.swift
//  GeekBrains-ClientServerApp
//
//  Created by Sergey Mikhailov on 25/04/2019.
//  Copyright © 2019 Sergey Mikhailov. All rights reserved.
//

import Foundation

class Session {
    
    static let instance = Session()
    
    private init(){}
    
    var token = ""
    var userId = ""
}
