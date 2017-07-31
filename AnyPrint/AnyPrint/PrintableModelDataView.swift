//
//  PrintableModelDataView.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 7/17/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import UIKit

class PrintableModelDataView: CustomUIView {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var fileType: UILabel!
    @IBOutlet weak var fileLocation: UILabel!
    @IBOutlet weak var fileSize: UILabel!
    @IBOutlet weak var uploadDate: UILabel!
    
    var printableModel: PrintableModel? {
        didSet {
            name.text = printableModel?.name
            fileType.text = printableModel?.type.rawValue
            fileLocation.text = printableModel?.location.rawValue
            fileSize.text = printableModel?.size.asDiskSpace()
            uploadDate.text = printableModel?.upload.asFormattedDate()
        }
    }
}
