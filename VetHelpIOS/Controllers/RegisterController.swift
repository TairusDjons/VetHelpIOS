//
//  RegisterController.swift
//  VetHelpIOS
//
//  Created by VetDev1 on 15.11.17.
//  Copyright © 2017 VetDev1. All rights reserved.
//

import UIKit
import Alamofire
import ReCaptcha
import Result
import RxSwift

class RegisterController: UIViewController {
    //MARK: Properties
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatpassword: UITextField!
    
    fileprivate static let webViewTag = 123
    

    
    // swiftlint:disable force_try
    let recaptcha = try? ReCaptcha()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recaptcha?.configureWebView { [weak self] webview in
            webview.frame = self?.view.bounds ?? CGRect.zero
            webview.tag = RegisterController.webViewTag
        }
        // Do any additional setup after loading the view.
    }
    
   
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func loginOnTap(_ sender: Any) {
        let email = emailTextField.text
        let username = usernameTextField.text
        let password = passwordTextField.text
        let repeatPassword = repeatpassword.text
        
        if password != repeatPassword{
            alertMessage(usrMessage: "Поле пароля и Подвтверждение пароля не совпадают")
            return
        }
        
        if email!.isEmpty || username!.isEmpty || password!.isEmpty || repeatPassword!.isEmpty {
            alertMessage(usrMessage: "Заполните все поля")
        }
        
        
        validateAndLogin()

    }
    
    
    
    func alertMessage(usrMessage: String) {
        var alert = UIAlertController(title: "Alert", message: usrMessage, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func validateAndLogin() {
        var captcha: String!
        recaptcha?.validate(on: view) { [weak self] result in
            switch result {
            case.success(let value):
                captcha=value
                switch ClientService.registerUser(email:(self?.emailTextField.text!)!,
                                                  username: (self?.usernameTextField.text!)!,
                                                  password: (self?.passwordTextField.text!)!,
                                                  reCaptcha: captcha!)  {
                case .success(let value):
                    print(value)
                case .error(let error):
                    print (error)
                    
                }
            case.failure(let error):
                print(error)
            }
        }
        
        
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

