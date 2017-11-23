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
       OAuth.oauth2 = OAuth2PasswordGrant(settings:[
            "client_id": "mobile",
            "client_secret": "MobileSecret",
            "token_uri": "https://vethelpidentity.azurewebsites.net/connect/token",   // code grant only
            "username": username,
            "password": password
            ] as OAuth2JSON)
        OAuth.oauth2?.username = username
        OAuth.oauth2?.password = password
        var isSucceed: Bool?
        var answer: Any?
        
        OAuth.oauth2?.authorize() { authParameters, error in
            if let params = authParameters {
                isSucceed = true
                answer = params
                OnCompleted(.success(answer))
                
            }
            else {
                isSucceed = false
                answer = error
                OnCompleted(.error(error))
                
            }
        
        }
        
        
        
        OAuth.oauth2?.useKeychain = true
        OAuth.oauth2?.storeTokensToKeychain()
        

        //oauth2.authConfig.authorizeEmbedded = true
        //oauth2.authConfig.authorizeContext = LoginController()
        
    }
    
    static func registerUser(
        email: String,
        username: String,
        password: String,
        reCaptcha: String)-> Result<String, Any>{
        
        var success: Bool?
        var nvalue: Any?
        var nerror: Error?
        
        let params: [String: Any]=[
            "email":email,
            "username":username,
            "password":password]
        
        let header: [String: String]=[
            "Content-Type":"application/json",
            "g-recaptcha-response":reCaptcha
        ]
        let api="https://vethelpidentity.azurewebsites.net/api/Account/Register"
        
        request(api, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON{ responseJSON in
            switch responseJSON.result {
            case .success(let value):
               success=true
       
            case .failure(let error):
                success=false
                nerror = error
            }
        }
        if (success)! {
            return .success("Регистрация прошла успешно")
        }
        else { return .error(nerror)}
        
    }
}
