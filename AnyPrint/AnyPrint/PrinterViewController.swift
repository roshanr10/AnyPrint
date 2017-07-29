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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Printers.sharedInstance.printers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = Printers.sharedInstance.printers[indexPath.row].config.url.absoluteString
        cell.accessoryType = Printers.sharedInstance.printers[indexPath.row] == Printers.sharedInstance.selected ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return Printers.sharedInstance.printers.count > 1
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removedElement = Printers.sharedInstance.printers.remove(at: indexPath.row)
            
            if removedElement == Printers.sharedInstance.selected {
                Printers.sharedInstance.selected = nil
            }
            
            Printers.save()
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let printerDetailViewController = segue.destination as? PrinterDetailViewController,
            let row = tableView.indexPathForSelectedRow?.row {
            printerDetailViewController.printer = Printers.sharedInstance.printers[row]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}
