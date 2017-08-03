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
    
    static func getState(for config: PrinterConfig, closure: @escaping (PrinterState?) -> ()) {
        getJSON(from: config, path: paths.stateRequest) { (jsonDict) in
            if let json = jsonDict,
                let stateObject = json["state"] as? [String: Any],
                let stateString = stateObject["text"] as? String,
                let temperatureObject = json["temperature"] as? [String: Any],
                let bedTemp = temperatureObject["bed"] as? [String: Any],
                let bedTempActual = bedTemp["actual"] as? Double,
                let bedTempTarget = bedTemp["target"] as? Double,
                let hotendTemp = temperatureObject["tool0"] as? [String: Any],
                let hotendTempActual = hotendTemp["actual"] as? Double,
                let hotendTempTarget = hotendTemp["target"] as? Double{
                    getJobState(for: config, closure: { job in
                        closure(
                            PrinterState(
                                state: stateString,
                                hotend: ToolTemperatureState(toolName: "Hotend", actualTemp: hotendTempActual, targetTemp: hotendTempTarget),
                                bed: ToolTemperatureState(toolName: "Bed", actualTemp: bedTempActual, targetTemp: bedTempTarget),
                                job: job
                            )
                        )
                    })
            } else {
                closure(nil)
            }
        }
    }
    
    static func getJobState(for config: PrinterConfig, closure: @escaping (JobState?) -> ()) {
        getJSON(from: config, path: paths.jobRequest) { (jsonDict) in
            if let json = jsonDict,
                let job = json["job"] as? [String: Any],
                let file = job["file"] as? [String: Any],
                let jobName = file["name"] as? String,
                let progress = json["progress"] as? [String: Any],
                let percent = progress["completion"] as? Double,
                let printTimeSpent = progress["printTime"] as? Int,
                let printTimeLeft = progress["printTimeLeft"] as? Int,
                let filament = job["filament"] as? [ String: [String: Any] ],
                let filamentLength = filament["tool0"]?["length"] as? Int,
                let filamentVolume = filament["tool0"]?["volume"] as? Double {
                    closure(
                        JobState(
                            job: jobName,
                            timeSpent: printTimeSpent,
                            timeLeft: printTimeLeft,
                            percentComplete: percent,
                            filament: FilamentState(length: filamentLength, volume: filamentVolume)
                        )
                    )
            } else {
                closure(nil)
            }
        }
    }

    static func getModels(for config: PrinterConfig, closure: @escaping ([PrintableModel]?) -> ()) {
        getJSON(from: config, path: paths.fileRequest) { (jsonDict) in
            if let json = jsonDict,
                let files = json["files"] as? [[String: Any]]{
                    let models: [PrintableModel] = files.map({ file in
                        if let name = file["name"] as? String,
                            let path = file["path"] as? String,
                            let typeString = file["type"] as? String,
                            let modelType = PrintableModelType(rawValue: typeString),
                            let size = file["size"] as? Int,
                            let date = file["date"] as? Int,
                            let locationString = file["origin"] as? String,
                            let location = PrintableModelLocation(rawValue: locationString){
                                return PrintableModel(
                                    name: name,
                                    path: path,
                                    location: location,
                                    type: modelType,
                                    size: size,
                                    upload: date)
                        } else {
                            return nil
                        }
                    }).flatMap({ $0 })
                    
                    closure(models)
            } else {
                closure(nil)
            }
        }
    }
    
    static func startPrint(for config: PrinterConfig, model: PrintableModel){
        let printPath = "\(paths.fileRequest)/\(model.location.rawValue)/\(model.path)"
        
        postJSON(to: config, path: printPath, data: [
            "command": "select",
            "print": "true"
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
    
    static func postJSON(to config: PrinterConfig, path: String, data: Parameters){
        postJSON(to: config, path: path, data: data) { response in }
    }
    
    static func postJSON(to config: PrinterConfig, path: String, data: Parameters, closure: @escaping ([String: Any]?) -> ()){
        let url = config.url.appendingPathComponent(path)
        
        let headers: HTTPHeaders = [
            "X-Api-Key": config.auth.apiKey
        ]
        
        Alamofire
            .request(url, method: .post, parameters: data, encoding: JSONEncoding.default, headers: headers)
            .authenticate(user: config.auth.http!.username!, password: config.auth.http!.password!)
            .response { response in
               
                print(response)
//                if let result = response.result.value,
//                    let JSON = result as? [String: Any] {
//                    closure(JSON)
//                } else {
//                    closure(nil)
//                }
            }
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
