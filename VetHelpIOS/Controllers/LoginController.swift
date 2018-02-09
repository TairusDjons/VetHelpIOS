//
//  LoginController.swift
//  VetHelpIOS
//
//  Created by VetDev1 on 15.11.17.
//  Copyright © 2017 VetDev1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import p2_OAuth2

class LoginController: UIViewController {
    
    @IBOutlet weak var whileLoginIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        view.addSubview(whileLoginIndicator)
        whileLoginIndicator.hidesWhenStopped = true
        if OAuth.oauth2.hasUnexpiredAccessToken() == true {
            performSegue(withIdentifier: "toMainTabBar", sender: self)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func goOfflineOnTap(_ sender: Any) {
        performSegue(withIdentifier: "toOfflineSegue", sender: self)
    }
    
    @IBAction func loginOnTap(_ sender: Any) {
        whileLoginIndicator.startAnimating()
       // performSegue(withIdentifier: "toMainTabBar", sender: self)
        ClientService.loginUser(username: usernameTextField!.text!, password: passwordTextField.text!){ result in
                switch result {
                case .success(_):
                    self.performSegue(withIdentifier: "toMainTabBar", sender: self)
                case .error(_):
                    self.alertMessage(usrMessage: "Неверный логин или пароль")
 
            }
        }
        whileLoginIndicator.stopAnimating()
        
    }
    
    
    
    func alertMessage(usrMessage: String) {
        let alert = UIAlertController(title: "Alert", message: usrMessage, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
   
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
    
    
}


