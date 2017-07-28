//
//  Printers.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 7/26/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import Foundation

class Printers: NSObject, NSCoding {
    var printers: [Printer] = []
    var selected: Printer?
    
    private override init() {
        super.init()
    }
    
    private struct PropertyKey {
        static let printers = "printers"
        static let selectedPrinter = "selectedPrinter"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        
        printers = aDecoder.decodeObject(forKey: PropertyKey.printers) as? [Printer] ?? []
        selected = aDecoder.decodeObject(forKey: PropertyKey.selectedPrinter) as? Printer
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(printers, forKey: PropertyKey.printers)
        aCoder.encode(selected, forKey: PropertyKey.selectedPrinter)
    }

    static let sharedInstance = reload()

    // Ref: https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/PersistData.html
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("printers")
    
    static func save() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(Printers.sharedInstance, toFile: Printers.ArchiveURL.path)
        
        if !isSuccessfulSave {
            print("Failed to save printers...")
        }
    }

    static func reload() -> Printers  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Printers.ArchiveURL.path) as? Printers ?? Printers()
    }
}
