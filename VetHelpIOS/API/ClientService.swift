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
class ClientService: BaseService{

    static let shared = ClientService()
    func loginUser(username: String, password: String, OnCompleted: @escaping (Result<Any, Any>)->()) {
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

    
    func checkEmail(email: String, OnCompleted: @escaping (Result<Any, Any>)->()) {
        let api = API.Base + API.IsEmailAvailable
        
        makeRequest(url: api, method: .get, OnCompleted: OnCompleted)
    }
    func checkLogin(login: String, OnCompleted: @escaping (Result<Any, Any>)->()) {
        let api = API.Base + API.IsUsernameAvailable + login
        
        makeRequest(url: api, method: .get, OnCompleted: OnCompleted)
    }
    
    func resetPassword(email: String,
                              reCaptcha: String,
                              OnCompleted: @escaping (Result <Any, Any>)->()) {
        let params: [String: Any]=[
            "email":email]
        
        let header: [String: String]=[
            "g-recaptcha-response":reCaptcha
        ]
        
        let api = API.Base + API.ForgotPassword
        makeRequest(url: api, method: .post, parameters: params, headers: header, OnCompleted: OnCompleted)
    }
    
    
    	func registerUser(
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
            "g-recaptcha-response":reCaptcha
        ]
        let api = API.Base + API.Register
        makeRequest(url: api, method: .post, parameters: params, headers: header, OnCompleted: OnCompleted)
    }
    
    func getUserInfo(OnCompleted: @escaping (Result<Any, Any>)->()) {
        let api = API.Base + API.Info
        let params: [String: Any] = [
            "Authorization": "Bearer " + OAuth.oauth2.accessToken!
        ]
        makeRequest(url: api, method: .get, parameters: params, OnCompleted: OnCompleted)
    }
    
    static func logout() {
        OAuth.oauth2.forgetTokens()
        let storage = HTTPCookieStorage.shared
        storage.cookies?.forEach() { storage.deleteCookie($0) }    }
}
