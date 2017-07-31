//
//  Int.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 7/30/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import Foundation

extension Int {
    // https://stackoverflow.com/a/40794726
    func asHMS() -> String {
        let hours   = self / 3600
        let minutes = (self % 3600) / 60
        let seconds = (self % 3600) % 60
        
    
        return "\(hours):\(minutes):\(seconds)"
    }
}
