//
//  OctoprintAPI.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 7/25/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import Foundation
import Alamofire

class OctoprintAPI {
    static func getState(for config: PrinterConfig, closure: (PrinterState) -> ()) {
        Alamofire.request("https://httpbin.org/get").responseJSON { response in }
    }
    
    static func getModels(for config: PrinterConfig, closure: (PrintableModels) -> ()) {
        Alamofire.request("https://httpbin.org/get").responseJSON { response in
            if let json = response.result.value {
                print("JSON: \((json as? [String: Any])?["headers"])") // serialized json response
            }
        }
    }
}
