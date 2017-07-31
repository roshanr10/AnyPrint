//
//  CameraConfig.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 7/30/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import Foundation

class CameraConfig: NSObject, NSCoding {
    var url: URL
    var auth: BasicAuth?
    
    private struct PropertyKey {
        static let url = "url"
        static let auth = "auth"
    }
    
    init(url: URL, auth: BasicAuth?){
        self.url = url
        self.auth = auth
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let url = aDecoder.decodeObject(forKey: PropertyKey.url) as? URL else { return nil }
        
        self.init(
            url: url,
            auth: aDecoder.decodeObject(forKey: PropertyKey.auth) as? BasicAuth
        )
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(url, forKey: PropertyKey.url)
        aCoder.encode(auth, forKey: PropertyKey.auth)
    }
}
