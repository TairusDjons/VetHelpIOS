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
    
    enum Result<T> {
        case success(T)
        case error(String)
    }
    
    static func loginUser(username: String, password: String) {
        OAuth.oauth2 = OAuth2PasswordGrant(settings:[
            "client_id": "mobile",
            "client_secret": "MobileSecret",
            "token_uri": "https://vethelpidentity.azurewebsites.net/connect/token",   // code grant only
            "username": username,
            "password": password
            ] as OAuth2JSON)
        
        OAuth.oauth2?.authorize() { authParameters, error in
            if let params = authParameters {
                print("Authorized! Access token is in `oauth2.accessToken`")
                print("Authorized! Additional parameters: \(params)")
            }
            else {
                print("Authorization was canceled or went wrong: \(error)")   // error will not be nil
            }
        
        }
     

        //oauth2.authConfig.authorizeEmbedded = true
        //oauth2.authConfig.authorizeContext = LoginController()
        
    }
    
    static func registerUser(
        email: String,
        username: String,
        password: String,
        reCaptcha: String)-> Result<String>{
        
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
        else { return .error(nerror as! String) }
        
    }
}
