//
//  BreedJsonParse.swift
//  VetHelpIOS
//
//  Created by VetDev1 on 26.02.2018.
//  Copyright © 2018 VetDev1. All rights reserved.
//

import Foundation
import SwiftyJSON
extension Breed {
    init?(json: JSON) {
        self.name = json["name"].stringValue
        self.animalType = AnimalType(json: json["animalType"])!
        self.id = json["id"].intValue
    }
    
    func toJSON()->JSON {
        return [
            "name": self.name as Any,
            "id": self.id as Any
        ]
    }
}
