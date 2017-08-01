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
    private struct paths {
        static let jobRequest = "/api/job"
    }
    
    static func isApiWorking(for config: PrinterConfig, closure: (Bool) -> ()){
        // Placeholder for Future Verification
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
    
    static func startPrint(for config: PrinterConfig, model: PrintableModel){
    
    }
    
    static func pausePrint(for config: PrinterConfig){
        // Alamofire.request(config.url.appendingPathComponent(paths.jobRequest), headers: ["X-Api-Key": config.auth.apiKey]).responseJSON { _ in }
    }
    
    static func stopPrint(for config: PrinterConfig){
    
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
