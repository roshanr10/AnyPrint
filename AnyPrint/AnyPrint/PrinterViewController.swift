//
//  PrinterViewController.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 7/26/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import UIKit

class PrinterViewController: UITableViewController {
    struct Constants {
        static let reuseIdentifier = "printerConfigCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Hello")
        
        Printers.sharedInstance.printers.append(
            Printer(
                PrinterConfig(
                    url: "http://3dprint.roshanravi.com",
                    camera: CameraConfig(
                        url: "http://3dprint.roshanravi.com",
                        auth: nil
                    ),
                    auth: nil
                )
            )
        )
        
        Printers.save()
        
        print(Printers.sharedInstance.printers.count)
        
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Printers.sharedInstance.printers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath)
        
        if(Printers.sharedInstance.printers[indexPath.row] == Printers.sharedInstance.selected){
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}
