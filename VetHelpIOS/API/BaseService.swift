//
//  BaseService.swift
//  VetHelpIOS
//
//  Created by VetDev1 on 26.02.2018.
//  Copyright © 2018 VetDev1. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
class BaseService {
    enum Result<T, T1> {
        case success(T)
        case error(T1)
    }
    init () {
        
    }
    
    func makeRequest(url: URLConvertible,
                     method: HTTPMethod,
                     parameters: Parameters? = nil,
                     encoding: ParameterEncoding? = JSONEncoding.default,
                     headers: HTTPHeaders? = nil,
                    OnCompleted: @escaping (Result<Any, Any>)->()) {
        request(url, method: method, parameters: parameters, encoding: encoding!, headers: headers).responseJSON{ responseJSON in
            switch responseJSON.result {
            case .success(let value):
                OnCompleted(.success(value))
            case .failure(let value):
                OnCompleted(.error(value))
            }
        }
        
    }
}

