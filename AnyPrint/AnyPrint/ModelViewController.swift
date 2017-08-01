//
//  ModelsViewController.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 8/1/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import UIKit

class ModelViewController: UITableViewController {
    struct Constants {
        static let reuseIdentifier = "modelViewCell"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Printers.sharedInstance.selected?.models?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = Printers.sharedInstance.selected?.models?[indexPath.row].name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let modelDetailViewController = segue.destination as? ModelDetailViewController,
            let row = tableView.indexPathForSelectedRow?.row {
            modelDetailViewController.model = Printers.sharedInstance.selected?.models?[row]
        }
    }
 
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}
