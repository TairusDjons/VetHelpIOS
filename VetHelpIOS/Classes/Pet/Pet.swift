//
//  User.swift
//  VetHelpIOS
//
//  Created by VetDev1 on 26.02.2018.
//  Copyright © 2018 VetDev1. All rights reserved.
//

import Foundation
struct Pet {
    var name: String
    var sex: Int
    var type: AnimalType {
        get {
            return self.breed.animalType
        }
        set(type) {
            self.breed.animalType = type
        }
    }
    var birthDate: String
    var breedId: Int {
        get {
            return self.breed.id
        }
    }
    var breed: Breed
    var id: Int
}
