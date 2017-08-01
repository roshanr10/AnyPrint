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
        
        reloadState()
        reloadModels()
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
    
    func reloadState(){
        OctoprintAPI.getState(for: config)  { (state) in self.state = state }
    }

    func reloadModels(){
        OctoprintAPI.getModels(for: config) { (models) in self.models = models }
    }
}
