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
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            streamingController = MjpegStreamingController(imageView: imageView)
            
            streamingController?.authenticationHandler = { challenge in
                return (.useCredential, URLCredential(
                    user: self.cameraConfig?.auth?.username ?? "",
                    password: self.cameraConfig?.auth?.password ?? "",
                    persistence: .none
                ))
            }
        }
    }
    
    var cameraConfig: CameraConfig? {
        didSet {
            if let cameraStreamer = streamingController {
                cameraStreamer.contentURL = cameraConfig?.url
                cameraStreamer.play()
            }
        }
    }
}
