//
//  PrinterAuth.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 7/30/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import Foundation

class PrinterAuth: NSObject, NSCoding {
    var apiKey: String
    var http: BasicAuth?
    
    private struct PropertyKey {
        static let apiKey = "apiKey"
        static let http = "http"
    }
    
    init(apiKey: String, httpAuth: BasicAuth?){
        self.apiKey = apiKey
        self.http = httpAuth
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let apiKey = aDecoder.decodeObject(forKey: PropertyKey.apiKey) as? String else { return nil }
        
        self.init(
            apiKey: apiKey,
            httpAuth: aDecoder.decodeObject(forKey: PropertyKey.http) as? BasicAuth
        )
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(apiKey, forKey: PropertyKey.apiKey)
        aCoder.encode(http, forKey: PropertyKey.http)
    }
}
