//
//  PrinterConfig.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 7/25/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import Foundation

class PrinterConfig: NSObject, NSCoding {
    var name: String
    var url: URL
    var camera: CameraConfig
    var auth: PrinterAuth
    
    private struct PropertyKey {
        static let name = "name"
        static let url = "url"
        static let cameraConfig = "cameraConfig"
        static let auth = "auth"
    }
    
    init(name: String, url: URL, camera: CameraConfig, auth: PrinterAuth){
        self.name = name
        self.url = url
        self.camera = camera
        self.auth = auth
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else { return nil }
        guard let url = aDecoder.decodeObject(forKey: PropertyKey.url) as? URL else { return nil }
        guard let camera = aDecoder.decodeObject(forKey: PropertyKey.cameraConfig) as? CameraConfig else { return nil }
        guard let auth = aDecoder.decodeObject(forKey: PropertyKey.auth) as? PrinterAuth else { return nil }
        
        self.init(
            name: name,
            url: url,
            camera: camera,
            auth: auth
        )
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(url, forKey: PropertyKey.url)
        aCoder.encode(camera, forKey: PropertyKey.cameraConfig)
        aCoder.encode(auth, forKey: PropertyKey.auth)
    }
}
