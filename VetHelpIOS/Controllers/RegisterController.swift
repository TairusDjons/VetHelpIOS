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

class RegisterController: UIViewController{
    //MARK: Properties
    typealias completion = () -> ()
    
    //Color for controllers
    
    
    //Controllers outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatpassword: UITextField!
    @IBOutlet weak var usernameError: UILabel!
    @IBOutlet weak var emailError: UILabel!
    
    @IBAction func checkEmailOnTap(_ sender: Any) {
        checkEmailOrLogin()
        
    }
    
    
    @IBAction func checkEmailEvent(_ sender: Any) {
        checkEmailOrLogin(email: true)
    }
    @IBAction func checkLoginEvent(_ sender: Any) {
        checkEmailOrLogin(login: true)
    }
    
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
    
    func validateAndLogin() {
        var captcha: String!
        
        recaptcha?.validate(on: view) { [weak self] result in
            switch result {
            case.success(let value):
                captcha=value
                
                ClientService.shared.registerUser(email:(self?.emailTextField.text!)!,
                                           username: (self?.usernameTextField.text!)!,
                                           password: (self?.passwordTextField.text!)!,
                                           reCaptcha: captcha!) { result in
                                            switch result {
                                            case .success(let value):
                                                self?.alertMessage(usrMessage: "Регистрация прошла успешно") {alert in self?.performSegue(withIdentifier: "backToLogin", sender: self)
                                                }
                                                
                                            case .error(let error):
                                                self?.alertMessage(usrMessage: error as! String)
                                                
                                            }
                }
            case.failure(let error):
                print(error)
            }
        }
    }
    
    
    func alertMessage(usrMessage: String, usrHandler: ((UIAlertAction)->Void)? = nil) {
        let alert = UIAlertController(title: "Alert", message: usrMessage, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func setLabel(field: UILabel,
                       isHidden: Bool? = true,
                       text: String? = "none",
                       color: UIColor? = UIColor.white) {
        field.text = text
        field.isHidden = isHidden!
        field.textColor = color
        
    }
    
    
    func checkEmailOrLogin(email: Bool? = false, login: Bool? = false){
        if (self.emailTextField.hasText && email!) {
            ClientService.shared.checkEmail(email: self.emailTextField.text!) {result in
                switch result {
                case .success(let value):
                    self.setLabel(field: self.emailError, isHidden: true)
                    self.emailTextField.backgroundColor = Colors.defColor
                case .error(let value):
                    self.setLabel(field: self.emailError, isHidden: false, text: "Введенная почта занята", color: Colors.errorTextColor)
                    self.emailTextField.backgroundColor = Colors.errorBackColor
                    //self.alertMessage(usrMessage: "Введенная почта уже занята")
                }
            }
        }
        if (self.emailTextField.hasText && login!) {
        
            ClientService.shared.checkLogin(login: self.usernameTextField.text!) {result in
                switch result {
                case .success(let value):
                    self.setLabel(field: self.usernameError, isHidden: true)
                    self.usernameTextField.backgroundColor = Colors.defColor
                case .error(let value):
                    self.setLabel(field: self.usernameError, isHidden: false, text: "Введенное имя занято", color: Colors.errorTextColor)
                    self.usernameTextField.backgroundColor = Colors.errorBackColor
                }
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

