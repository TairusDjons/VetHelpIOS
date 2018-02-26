//
//  PetJsonParse.swift
//  VetHelpIOS
//
//  Created by VetDev1 on 26.02.2018.
//  Copyright © 2018 VetDev1. All rights reserved.
//

import Foundation
import SwiftyJSON
extension Pet {
    init?(json: JSON) {
        self.name = json["name"].stringValue
        self.sex = json["sex"].intValue
        self.birthDate = json["birthDate"].stringValue
        self.breed = Breed(json: json["breed"])!
        self.id = json["id"].intValue
    }
    
    func toJSON()->JSON {
        return [
            "name": self.name as Any,
            "sex": self.sex as Any,
            "birthDate": self.birthDate as Any,
            "id": self.id as Any
        ]
    }
}
