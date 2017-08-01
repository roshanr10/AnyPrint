//
//  PrintableModels.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 7/25/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import Foundation

struct PrintableModel {
    let name: String
    let path: String
    let location: PrintableModelLocation
    let type: PrintableModelType
    let size: Int
    let upload: Int // Unix Timestamp

}

enum PrintableModelLocation: String {
    case local  = "Local"
    case sdcard = "SD Card"
}

enum PrintableModelType: String {
    case model          = "Model"
    case machinecode    = "Machine Code"
}
