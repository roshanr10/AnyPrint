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
        static let stateRequest = "/api/printer"
        static let fileRequest  = "/api/files"
        static let jobRequest   = "/api/job"
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
        // Derived from: https://stackoverflow.com/questions/27026916/sending-json-array-via-alamofire
        var request = URLRequest(url: config.url)
        request.httpMethod = "POST"
        request.setValue(config.auth.apiKey, forHTTPHeaderField: "X-Api-Key")
        
        request.httpBody = try! JSONSerialization.data(withJSONObject:  [
            "command": "pause",
            "action": "pause"
        ])
        
        Alamofire
            .request(request)
            .authenticate(user: config.auth.http!.username!, password: config.auth.http!.password!)
            .responseJSON { response in }
    }
    
    static func stopPrint(for config: PrinterConfig){
        // Derived from: https://stackoverflow.com/questions/27026916/sending-json-array-via-alamofire
        var request = URLRequest(url: config.url)
        request.httpMethod = "POST"
        request.setValue(config.auth.apiKey, forHTTPHeaderField: "X-Api-Key")
        
        request.httpBody = try! JSONSerialization.data(withJSONObject:  [
            "command": "cancel"
            ])
        
        Alamofire
            .request(request)
            .authenticate(user: config.auth.http!.username!, password: config.auth.http!.password!)
            .responseJSON { response in }
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
