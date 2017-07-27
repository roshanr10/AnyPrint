//
//  PrinterViewController.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 7/26/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import UIKit

class PrinterViewController: UITableViewController {

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
