//
//  Printer.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 7/25/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import Foundation

class Printer: NSObject, NSCoding {
    var config: PrinterConfig
    var state: PrinterState?
    
    var models: [PrintableModel]?
    
    init(_ config: PrinterConfig) {
        self.config = config
        
        super.init()
        
        reload()
    }
    
    private struct PropertyKey {
        static let config = "config"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let config = aDecoder.decodeObject(forKey: PropertyKey.config) as? PrinterConfig else { return nil }
        
        self.init(config)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(config, forKey: PropertyKey.config)
    }
    
    func reload(){
        OctoprintAPI.getState(for: config)  { state in
            self.state = state
            NotificationCenter.default.post(name: .printerStateChange, object: nil)
        }
        
        OctoprintAPI.getModels(for: config) { models in
            self.models = models
            NotificationCenter.default.post(name: .printerModelChange, object: nil)
        }
    }
}

// Derived from: https://medium.com/@JoyceMatos/using-nsnotificationcenter-in-swift-eb70cf0b60fc
extension Notification.Name {
    static let printerStateChange = Notification.Name("printerStateChange")
    static let printerModelChange = Notification.Name("printerModelChange")
}
