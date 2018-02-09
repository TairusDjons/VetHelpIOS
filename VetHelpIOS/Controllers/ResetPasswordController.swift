//
//  ResetPasswordController.swift
//  VetHelpIOS
//
//  Created by VetDev1 on 26.12.2017.
//  Copyright © 2017 VetDev1. All rights reserved.
//

import UIKit
import Alamofire
import ReCaptcha
import Result
import RxSwift

class ResetPasswordController: UIViewController {
    
    fileprivate static let webViewTag = 123
    
    var defColor = UIColor(hue: 0, saturation: 0, brightness: 1, alpha: 1.0)
    var errorBackColor = UIColor(hue: 0, saturation: 0.33, brightness: 1, alpha: 1.0)
    
    @IBOutlet weak var emailTextField: UITextField!

    
    @IBAction func emailIsNullEvent(_ sender: Any) {
        if (emailTextField.text?.isEmpty)! {
            emailTextField.backgroundColor = errorBackColor
        }
        else {
            emailTextField.backgroundColor = defColor
        }
    }

    
    @IBAction func changePasswordOnTap(_ sender: Any) {
        
        if ((emailTextField.text?.isEmpty)!) {
            alertMessage(usrMessage: "Одно из полей не заполнено", doAction: {return})
        }
        else {
            self.validateAndChangePassword()
        }
    }
    
    
    func validateAndChangePassword() {
        var captcha: String!
        recaptcha?.validate(on: view) { [weak self] result in
            switch result {
            case.success(let value):
                captcha=value
                ClientService.resetPassword(email:(self?.emailTextField.text!)!,
                                            reCaptcha: captcha!) { result in
                                            switch result {
                                            case .success(let value):
                                                self?.alertMessage(usrMessage: value as! String, doAction: {
                                                    self?.performSegue(withIdentifier: "toLoginControllerSegue", sender: nil)
                                                    
                                                })
                                            case .error(let error):
                                                self?.alertMessage(usrMessage: error as! String, doAction: { return })
                                                
                                            }
                }
            case.failure(let error):
                print(error)
            }
        }
    }
    
    // swiftlint:disable force_try
    let recaptcha = try? ReCaptcha()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recaptcha?.configureWebView { [weak self] webview in
            webview.frame = self?.view.bounds ?? CGRect.zero
            webview.tag = ResetPasswordController.webViewTag
        }
        // Do any additional setup after loading the view.
    }
    
    
    func alertMessage(usrMessage: String, doAction:@escaping ()->()?) {
        let alert = UIAlertController(title: "Пароль сменен", message: usrMessage, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {action in
            doAction()
        })
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
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
