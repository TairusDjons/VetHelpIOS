//
//  APIconst.swift
//  VetHelpIOS
//
//  Created by VetDev1 on 21.01.2018.
//  Copyright © 2018 VetDev1. All rights reserved.
//

import Foundation
public class API {
    // Base
    static let Base = "https://vethelp.azurewebsites.net/"
    
    // Account endpoints
    static let IsEmailAvailable = "api/Account/IsEmailAvailable/"
    static let IsUsernameAvailable = "api/Account/IsUsernameAvailable/"
    static let ForgotPassword = "api/Account/ForgotPassword"
    static let Register = "api/Account/Register"
    static let Login = "connect/token"
    static let Info = "connect/userinfo"
    
    // Pet endpoints
    static let AnimalTypes = "api/AnimalTypes"
    static let Breeds = "api/Breeds"
    static let UserPet = "api/UserPet"
}
