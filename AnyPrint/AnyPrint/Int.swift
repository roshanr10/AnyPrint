//
//  Int.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 7/30/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import Foundation

extension Int {
    // Derived from: https://stackoverflow.com/a/40794726
    func asHMS() -> String {
        // TODO: Review https://stackoverflow.com/a/35215847
        let hours   = self / 3600
        let minutes = (self % 3600) / 60
        let seconds = (self % 3600) % 60
    
        return "\(hours):\(minutes):\(seconds)"
    }
    
    // Derived from: https://stackoverflow.com/a/44321852
    func asDiskSpace() -> String {
        return ByteCountFormatter.string(fromByteCount: Int64(self), countStyle: .file)
    }
    
    // Derived from: http://www.codingexplorer.com/swiftly-getting-human-readable-date-nsdateformatter/
    func asFormattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(self)))
    }
}
