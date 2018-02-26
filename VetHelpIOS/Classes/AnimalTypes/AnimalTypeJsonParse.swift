//
//  AnimalTypeJsonParse.swift
//  VetHelpIOS
//
//  Created by VetDev1 on 26.02.2018.
//  Copyright © 2018 VetDev1. All rights reserved.
//

import Foundation
import SwiftyJSON
extension AnimalType {
    init?(json: JSON) {
        self.name = json["name"].stringValue
        let breeds = json["breeds"]
        var tempBreeds = [Breed]()
        for (index, subJson) in breeds {
            let breed = Breed(json: subJson)
            tempBreeds.append(breed!)
        }
        self.breeds = tempBreeds
        self.id = json["id"].intValue
    }
    
    func toJSON()->JSON {
        return [
            "name": self.name as Any,
            "id": self.id as Any
        ]
    }
}
