//
//  LoginNavigationController.swift
//  VetHelpIOS
//
//  Created by VetDev1 on 21.11.17.
//  Copyright © 2017 VetDev1. All rights reserved.
//

import UIKit

class LoginNavigationController: UINavigationController {

    
    override func viewDidAppear(_ animated: Bool) {
       
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if OAuth.oauth2 == nil{
            performSegue(withIdentifier: "toOfflineTabBar", sender: self)
        }
        
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
