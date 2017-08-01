//
//  DetailViewController.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 7/27/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var cameraStream: MJPGCameraStreamView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraStream.cameraConfig = Printers.sharedInstance.selected?.config.camera
    }
    
    @IBAction func pausePrint(_ sender: Any) {
        if let config = Printers.sharedInstance.selected?.config {
            OctoprintAPI.pausePrint(for: config)
        }
    }
    
    @IBAction func stopPrint(_ sender: Any) {
        if let config = Printers.sharedInstance.selected?.config {
            OctoprintAPI.stopPrint(for: config)
        }
    }
}
