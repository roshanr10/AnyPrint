//
//  PrinterState.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 7/25/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import Foundation

struct PrinterState {
    let state: String
    let tools: [ToolTemperatureState]
    let bed: ToolTemperatureState?
    
    let job: JobState?
}

struct ToolTemperatureState {
    let toolName: String
    
    let actualTemp: Double
    let targetTemp: Double
}

struct JobState {
    let job: String
    
    let timeSpent: Int
    let timeLeft: Int
    
    let percentComplete: Double
    
    let filament: FilamentState
}

struct FilamentState {
    let length: Int
    let volume: Double
}
