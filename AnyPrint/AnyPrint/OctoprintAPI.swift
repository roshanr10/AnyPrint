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
        static let jobStateRequest = "/api/printer"
        static let fileRequest  = "/api/files"
        static let jobRequest   = "/api/job"
    }
    
    static func isApiWorking(for config: PrinterConfig, closure: (Bool) -> ()){
        // Placeholder for Future Verification
        closure(true)
    }
    
    static func getState(for config: PrinterConfig, closure: @escaping (PrinterState?) -> ()) {
        getJSON(from: config, path: paths.stateRequest) { (jsonDict) in
            if let json = jsonDict,
                let stateString = (json["state"] as? [String: Any])?["text"] as? String {
                closure(
                    PrinterState(
                        state: stateString,
                        tools: [],
                        bed: nil,
                        job: nil
                    )
                )
            } else {
                closure(nil)
            }
        }
    }
    
    static func getModels(for config: PrinterConfig, closure: @escaping ([PrintableModel]?) -> ()) {
        getJSON(from: config, path: paths.fileRequest) { (jsonDict) in
            if let json = jsonDict {
                closure([])
            } else {
                closure(nil)
            }
        }
    }
    
    static func startPrint(for config: PrinterConfig, model: PrintableModel){
        postJSON(to: config, path: paths.jobRequest, data: [
            "command": "start"
        ])
    }
    
    static func pausePrint(for config: PrinterConfig){
        postJSON(to: config, path: paths.jobRequest, data: [
            "command": "pause",
            "action": "pause"
        ])
    }
    
    static func stopPrint(for config: PrinterConfig){
        postJSON(to: config, path: paths.jobRequest, data: [
            "command": "cancel"
        ])
    }

    static func getJSON(from config: PrinterConfig, path: String, closure: @escaping ([String: Any]?) -> ()){
        var request = URLRequest(url: config.url.appendingPathComponent(path))
        request.httpMethod = "GET"
        request.setValue(config.auth.apiKey, forHTTPHeaderField: "X-Api-Key")
        
        Alamofire
            .request(request)
            .authenticate(user: config.auth.http!.username!, password: config.auth.http!.password!)
            .responseJSON { response in
                if let result = response.result.value,
                    let JSON = result as? [String: Any] {
                    closure(JSON)
                } else {
                    closure(nil)
                }
        }
    }
    
    static func postJSON(to config: PrinterConfig, path: String, data: Any){
        // Derived from: https://stackoverflow.com/questions/27026916/sending-json-array-via-alamofire
        var request = URLRequest(url: config.url.appendingPathComponent(path))
        request.httpMethod = "POST"
        request.setValue(config.auth.apiKey, forHTTPHeaderField: "X-Api-Key")
        
        request.httpBody = try? JSONSerialization.data(withJSONObject:  data)
        
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
