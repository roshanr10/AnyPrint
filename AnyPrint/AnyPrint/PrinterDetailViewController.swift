//
//  PrinterDetailViewController.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 7/27/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import UIKit

class PrinterDetailViewController: UIViewController {
    var printer: Printer?
    
    @IBOutlet weak var printerHost: UITextField!
    @IBOutlet weak var apiKey: UITextField!
    @IBOutlet weak var cameraHost: UITextField!
    
    @IBOutlet weak var basicAuth: UISwitch!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        if let config = printer?.config {
            printerHost.text = config.url.absoluteString
            apiKey.text = config.auth.apiKey
            
            cameraHost.text = config.camera.url.absoluteString
            
            if let auth = config.auth.http {
                basicAuth.isOn = true
                
                username.text = auth.username
                password.text = auth.password
            } else {
                basicAuth.isOn = false
            }
        }
    }
    
    @IBAction func submitEdits(_ sender: Any) {        guard let printerHostURL = printerHost.text else { return }
        guard let url = URL(string: printerHostURL) else { return }
        guard let apiKey = apiKey.text else { return }
        guard let cameraHostURL = cameraHost.text else { return }
        guard let cameraHost = URL(string: cameraHostURL) else { return }
        guard let username = username.text else { return }
        guard let password = password.text else { return }
        
        let auth = basicAuth.isOn ? BasicAuth(
            username: username,
            password: password
        ) : nil
        
        let cameraConfig = CameraConfig(
            url: cameraHost,
            auth: auth
        )
        
        let printerAuth = PrinterAuth(
            apiKey: apiKey,
            httpAuth: auth
        )
        
        let tempConfig = PrinterConfig(
            url: url,
            camera: cameraConfig,
            auth: printerAuth
        )
        
        // Show Loading Symbol (Network).?
        OctoprintAPI.isApiWorking(for: tempConfig) { (working) in
            // Hide Loading Symbol (Network).?
            
            if working {
                // Don't replace Config. due to Ref. Semantics
                if let config = printer?.config {
                    config.url = tempConfig.url
                    config.camera = tempConfig.camera
                    config.auth = tempConfig.auth
                } else {
                    Printers.sharedInstance.printers.append(
                        Printer(tempConfig)
                    )
                }
                
                self.navigationController?.popViewController(animated: true)
            } else {
                // Alert User that Printer Cred's Aren't Valid
            }
        }
    }
    
    @IBAction func selectPrinter(_ sender: Any) {
        Printers.sharedInstance.selected = printer
        
        self.navigationController?.popViewController(animated: true)
    }
}
