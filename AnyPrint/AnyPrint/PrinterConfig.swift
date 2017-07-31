//
//  PrinterConfig.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 7/25/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import Foundation

class PrinterConfig: NSObject, NSCoding {
    var url: URL
    var camera: CameraConfig
    var auth: PrinterAuth
    
    private struct PropertyKey {
        static let url = "url"
        static let cameraConfig = "cameraConfig"
        static let auth = "auth"
    }
    
    init(url: URL, camera: CameraConfig, auth: PrinterAuth){
        self.url = url
        self.camera = camera
        self.auth = auth
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let url = aDecoder.decodeObject(forKey: PropertyKey.url) as? URL else { return nil }
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
    }
}
