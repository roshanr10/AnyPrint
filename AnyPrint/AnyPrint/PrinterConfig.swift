//
//  PrinterConfig.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 7/25/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import Foundation

class PrinterConfig: NSObject, NSCoding {
    var url: String
    var camera: CameraConfig
    var auth: PrinterAuth
    
    private struct PropertyKey {
        static let url = "url"
        static let cameraConfig = "cameraConfig"
        static let auth = "auth"
    }
    
    init(url: String, camera: CameraConfig, auth: PrinterAuth){
        self.url = url
        self.camera = camera
        self.auth = auth
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let url = aDecoder.decodeObject(forKey: PropertyKey.url) as? String else { return nil }
        guard let camera = aDecoder.decodeObject(forKey: PropertyKey.cameraConfig) as? CameraConfig else { return nil }
        guard let auth = aDecoder.decodeObject(forKey: PropertyKey.auth) as? PrinterAuth else { return nil }
        
        self.init(
            url: url,
            camera: camera,
            auth: auth
        )
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(url, forKey: PropertyKey.url)
        aCoder.encode(camera, forKey: PropertyKey.cameraConfig)
        aCoder.encode(auth, forKey: PropertyKey.auth)
    }}

class CameraConfig: NSObject, NSCoding {
    var url: String
    var auth: BasicAuth?
    
    private struct PropertyKey {
        static let url = "url"
        static let auth = "auth"
    }
    
    init(url: String, auth: BasicAuth?){
        self.url = url
        self.auth = auth
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let url = aDecoder.decodeObject(forKey: PropertyKey.url) as? String else { return nil }
        
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
