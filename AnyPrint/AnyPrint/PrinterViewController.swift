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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return Printers.sharedInstance.printers.count > 1
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Printers.sharedInstance.printers.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
