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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
            
            streamingController?.didStartLoading = { [unowned self] in
                self.activityIndicator.startAnimating()
            }
            
            streamingController?.didFinishLoading = { [unowned self] in
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    var cameraConfig: CameraConfig? {
        didSet {
            if let cameraStreamer = streamingController {
                cameraStreamer.contentURL = cameraConfig?.url
            }
        }
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        if let _ = newWindow {
            streamingController?.play()
        } else {
            streamingController?.stop()
        }
    }
}
