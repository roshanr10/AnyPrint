//
//  CameraStreamView.swift
//  AnyPrint
//
//  Created by Roshan Ravi on 7/17/17.
//  Copyright © 2017 Roshan Ravi. All rights reserved.
//

import UIKit
import MjpegStreamingKit

class MJPGCameraStreamView: CustomUIView {
    var streamingController: MjpegStreamingController?
    @IBOutlet weak var imageView: UIImageView!
    
    var url = URL(string: "") {
        didSet {
            streamingController?.contentURL = url
            streamingController?.play()
        }
    }
}
