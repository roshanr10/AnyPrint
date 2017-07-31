//
//  BasicAuth.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 7/30/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import Foundation

class BasicAuth: NSObject, NSCoding {
    var username: String?
    var password: String?
    
    private struct PropertyKey {
        static let username = "username"
        static let password = "password"
    }
    
    init(username: String?, password: String?){
        self.username = username
        self.password = password
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(
            username: aDecoder.decodeObject(forKey: PropertyKey.username) as? String,
            password: aDecoder.decodeObject(forKey: PropertyKey.password) as? String
        )
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(username, forKey: PropertyKey.username)
        aCoder.encode(password, forKey: PropertyKey.password)
    }
}
