//
//  Client.swift
//  VetHelpIOS
//
//  Created by VetDev1 on 18.11.17.
//  Copyright © 2017 VetDev1. All rights reserved.
//

import Foundation
import UIKit
import p2_OAuth2
import Alamofire
class ClientService {
    
    enum Result<T, T1> {
        case success(T)
        case error(T1)
    }
    
    static func loginUser(username: String, password: String, OnCompleted: @escaping (Result<Any, Any>)->()) {
        OAuth.oauth2.username = username
        OAuth.oauth2.password = password
        var answer: Any?
        
        OAuth.oauth2.authorize() { authParameters, error in
            if let params = authParameters {
                answer = params
                OnCompleted(.success(answer!))
            }
            else {
                answer = error
                OnCompleted(.error(error!))
            }
        
        }
        
        
        
        OAuth.oauth2.useKeychain = true
        //OAuth.oauth2.storeTokensToKeychain()
        

        //oauth2.authConfig.authorizeEmbedded = true
        //oauth2.authConfig.authorizeContext = LoginController()
        
    }
    
    
    
    static func checkEmail(email: String, OnCompleted: @escaping (Result<Any, Any>)->()) {
        let api = "https://vethelpidentity.azurewebsites.net/api/Account/IsEmailAvailable/" + email
        request(api, method: .get, encoding: JSONEncoding.default).responseJSON{ responseJSON in
            switch responseJSON.result {
            case .success(let value):
                let success = value as! Bool
                if success {
                    OnCompleted(.success("Email passed"))
                }
                else {OnCompleted(.error("Wrong email")) }
                
            case .failure(let error):
                OnCompleted(.error("Problem with connections"))
            }
        }
    }
    static func checkLogin(login: String, OnCompleted: @escaping (Result<Any, Any>)->()) {
        let api = "https://vethelpidentity.azurewebsites.net/api/Account/IsUsernameAvailable/" + login
        request(api, method: .get, encoding: JSONEncoding.default).responseJSON{ responseJSON in
            switch responseJSON.result {
            case .success(let value):
                let success = value as! Bool
                if success {
                    OnCompleted(.success("Email passed"))
                }
                else {OnCompleted(.error("Wrong email")) }
                
            case .failure(let error):
                OnCompleted(.error("Problem with connections"))
            }
        }
        
    }
    
    static func resetPassword(email: String,
                              newPassword: String,
                              reCaptcha: String,
                              OnCompleted: @escaping (Result <Any, Any>)->()) {
        let params: [String: Any]=[
            "email":email,
            "password":newPassword]
        
        let header: [String: String]=[
            "Content-Type":"application/json",
            "g-recaptcha-response":reCaptcha
        ]
        let api="https://vethelpidentity.azurewebsites.net/api/Account/ForgotPassword"
        
        request(api, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON{ responseJSON in
            switch responseJSON.result {
            case .success(let value):
                OnCompleted(.success("На вашу почту пришло сообщение о подтвержедении смены пароля"))
                
            case .failure(let error):
                OnCompleted(.error("Что-то пошло не так"))
            }
        }
    }
    
    
    static func registerUser(
        email: String,
        username: String,
        password: String,
        reCaptcha: String,
        OnCompleted: @escaping (Result<Any, Any>)->()){
        
        
        let params: [String: Any]=[
            "email":email,
            "username":username,
            "password":password
        ]
        
        let header: [String: String]=[
            "Content-Type":"application/json",
            "g-recaptcha-response":reCaptcha
        ]
        let api="https://vethelpidentity.azurewebsites.net/api/Account/Register"
        
        request(api, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON{ responseJSON in
            switch responseJSON.result {
            case .success(let value):
               OnCompleted(.success("Регистрация прошла успешно"))
       
            case .failure(let error):
                OnCompleted(.error("Что-то пошло не так"))
            }
        }
       
        
    }
    
    static func logout() {
        OAuth.oauth2.forgetClient()
        OAuth.oauth2.forgetTokens()
        let storage = HTTPCookieStorage.shared
        storage.cookies?.forEach() { storage.deleteCookie($0) }    }
}
