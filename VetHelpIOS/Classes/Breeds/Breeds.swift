//
//  Breeds.swift
//  VetHelpIOS
//
//  Created by VetDev1 on 26.02.2018.
//  Copyright © 2018 VetDev1. All rights reserved.
//

import Foundation
struct Breed {
    var name: String
    var animalTypeId: Int {
        get {
            return self.animalType.id
        }
    }
    var animalType: AnimalType
    var id: Int
}
