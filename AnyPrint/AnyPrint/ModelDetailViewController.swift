//
//  ModelDetailViewController.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 8/1/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import UIKit

class ModelDetailViewController: UIViewController {
    var model: PrintableModel?
    
    @IBOutlet weak var modelDataView: PrintableModelDataView!
    
    override func viewDidLoad() {
        if let modelInfo = model {
            modelDataView.printableModel = modelInfo
        }
    }
    
    @IBAction func printModel(_ sender: Any) {
        if let config = Printers.sharedInstance.selected?.config,
            let printableModel = model {
            OctoprintAPI.startPrint(for: config, model: printableModel)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
