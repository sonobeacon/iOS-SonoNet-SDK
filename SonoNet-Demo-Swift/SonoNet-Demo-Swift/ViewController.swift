//
//  ViewController.swift
//  SonoNet-Demo-Swift
//
//  Created by Sascha Melcher on 26.03.19.
//  Copyright © 2019 SonoBeacon. All rights reserved.
//

import UIKit
import sonolib

class ViewController: UIViewController {

    @IBOutlet weak var contentView: ContentView!

    let sonoNet = SonoNet.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        let config = SonoNetConfigBuilder { builder in
            builder.apiKey = "YOUR_API_KEY"
            builder.contentView = contentView               /* optional */
            builder.notifyMe = true                         /* optional */
            builder.hasMenu = true                          /* optional - integration is only possible in conjunction with contentView */
            builder.debugMode = true                        /* optional */
            builder.bluetoothOnly = false                   /* optional */
            builder.preferredMic = 1                        /* optional - front mic = 1 / back mic = 2 (default) / bottom mic = 0 */
        }

        guard let sonoNetConfig = SonoNetConfig(config) else { return }
        sonoNet.bind(withConfig: sonoNetConfig)

        sonoNet.didReceiveContent = { [weak self] content in
            guard let _ = self else { return }
            print("\(content.title)")
        }


    }


}

