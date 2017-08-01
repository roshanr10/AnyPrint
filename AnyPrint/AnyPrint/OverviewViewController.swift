//
//  OverviewViewController.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 7/27/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {
    @IBOutlet weak var cameraStream: MJPGCameraStreamView!
    
    @IBOutlet weak var printerName: UILabel!
    @IBOutlet weak var printerStatus: UILabel!
    @IBOutlet weak var hotend: ToolTemperatureView!
    @IBOutlet weak var bed: ToolTemperatureView!
    @IBOutlet weak var currentJob: CurrentPrintJobView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraStream.cameraConfig = Printers.sharedInstance.selected?.config.camera
        
        printerName.text = Printers.sharedInstance.selected?.config.name
        printerStatus.text = Printers.sharedInstance.selected?.state?.state
        
        if let tools = Printers.sharedInstance.selected?.state?.tools,
            tools.count > 0 {
            hotend.state = tools[0]
        }
        
        bed.state = Printers.sharedInstance.selected?.state?.bed
        
        currentJob.currentPrintJob = Printers.sharedInstance.selected?.state?.job
    }
}
