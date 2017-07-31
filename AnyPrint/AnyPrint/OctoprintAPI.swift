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
    private struct paths {}
    
    static func isApiWorking(for config: PrinterConfig, closure: (Bool) -> ()){
        closure(true)
    }
    
    static func getState(for config: PrinterConfig, closure: (PrinterState) -> ()) {
        // Alamofire.request("https://httpbin.org/get").responseJSON { response in }
    }
    
    static func getModels(for config: PrinterConfig, closure: (PrintableModels) -> ()) {
        /*Alamofire.request("https://httpbin.org/get").responseJSON { response in
            if let json = response.result.value {
                print("JSON: \((json as? [String: Any])?["headers"])") // serialized json response
            }
        }*/
    }
    
    static func startPrint(for config: PrinterConfig, model: PrintableModel, closure: () -> ()){
    
    }
    
    static func pausePrint(for config: PrinterConfig, closure: () -> ()){
    
    }
    
    static func stopPrint(for config: PrinterConfig, closure: () -> ()){
    
    }

    
    /*
     * Addt. Features to Add...
     * - Test API/Camera before Adding
     * - Start Print from Models
     * - Pause/Stop Print, Remove Stop Fans/Motors..?
     * - RSA app verification, easy install as opposed to API key
     * - Add possible lights facility ( may depend on backend plugin..)
     */
}
