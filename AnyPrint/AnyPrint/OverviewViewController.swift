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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraStream.cameraConfig = Printers.sharedInstance.selected?.config.camera
    }
}
