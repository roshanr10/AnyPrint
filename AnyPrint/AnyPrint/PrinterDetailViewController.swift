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
            printerHost.text = config.url
            apiKey.text = config.auth.apiKey
            
            cameraHost.text = config.camera.url
            
            if let auth = config.auth.http {
                basicAuth.isOn = true
                
                username.text = auth.username
                password.text = auth.password
            } else {
                basicAuth.isOn = false
            }
        }
    }
    
    @IBAction func submitEdits(_ sender: Any) {
        guard let url = printerHost.text else { return }
        guard let apiKey = apiKey.text else { return }
        guard let cameraHost = cameraHost.text else { return }
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
        
        // Don't replace Config. due to Ref. Semantics
        if let config = printer?.config {
            config.url = url
            config.auth.apiKey = apiKey
            config.camera = cameraConfig
        } else {
            Printers.sharedInstance.printers.append(
                Printer(
                    PrinterConfig(
                        url: url,
                        camera: cameraConfig,
                        auth: printerAuth
                    )
                )
            )
        }
        
        Printers.save()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectPrinter(_ sender: Any) {
        Printers.sharedInstance.selected = printer
        
        Printers.save()
        
        self.navigationController?.popViewController(animated: true)
    }
}
