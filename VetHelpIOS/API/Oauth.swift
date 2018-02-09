//
//  File.swift
//  VetHelpIOS
//
//  Created by VetDev1 on 18.11.17.
//  Copyright © 2017 VetDev1. All rights reserved.
//

import Foundation
import p2_OAuth2
class OAuth{
    static var oauth2 = OAuth2PasswordGrant(settings:[
        "client_id": "mobile",
        "client_secret": "MobileSecret",
        "token_uri": API.Login,   // code grant only
        "username": "",
        "password": "",
        ] as OAuth2JSON)}
