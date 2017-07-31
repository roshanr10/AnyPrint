//
//  PrintableModels.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 7/25/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import Foundation

struct PrintableModels {
    let models: [PrintableModel]
}

struct PrintableModel {
    let name: String
    let path: String
    let location: PrintableModelLocation
    let type: PrintableModelType
    let size: Int
    let upload: Int // Unix Timestamp

}

enum PrintableModelLocation: String {
    case local  = "local"
    case sdcard = "sdcard"
}

enum PrintableModelType: String {
    case model          = "model"
    case machinecode    = "machinecode"
}
