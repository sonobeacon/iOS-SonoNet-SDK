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
        let credentials = SonoNetCredentials(apiKey: "YOUR_API_KEY", locationId: "LOCATION_ID")
        sonoNet.bind(withCredentials: credentials, andOptionalContentView: contentView)
        
        sonoNet.didReceiveContent = { [weak self] content in
            guard let strongSelf = self else { return }
            print("\(content.title)")
        }
    }
    

}

