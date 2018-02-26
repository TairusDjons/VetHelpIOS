//
//  ViewController.swift
//  VetHelpIOS
//
//  Created by VetDev1 on 14.11.17.
//  Copyright © 2017 VetDev1. All rights reserved.
//

import UIKit
import SwiftyJSON
class ViewController: UIViewController {

    @IBOutlet weak var usernameTextView: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        ClientService.shared.getUserInfo() {
            result in
            switch result {
            case .success(let value):
                let json = JSON(value)
                self.usernameTextView.setTitle(json["name"].stringValue, for: .normal)
            case .error(let value):
                self.usernameTextView.setTitle("User", for: .normal)
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

