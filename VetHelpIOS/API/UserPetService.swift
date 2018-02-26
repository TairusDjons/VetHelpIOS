//
//  UserPetService.swift
//  VetHelpIOS
//
//  Created by VetDev1 on 26.02.2018.
//  Copyright © 2018 VetDev1. All rights reserved.
//

import Foundation
import SwiftyJSON
class UserPetService: BaseService {
    static let shared = UserPetService()
    
    let api = API.Base + API.UserPet
    let header: [String: String] = [
        "Authorization": "Bearer " + OAuth.oauth2.accessToken!
    ]
    
    func get(OnCompleted: @escaping (Result <Any, Any>)->()) {
        makeRequest(url: api, method: .get, headers: header, OnCompleted: OnCompleted)
    }
    
    func post(newPet: Pet, OnCompleted: @escaping (Result <Any, Any>)->()) {
        makeRequest(url: api, method: .post, parameters: newPet.toJSON().dictionaryObject, headers: header, OnCompleted: OnCompleted)
    }
    
    func put(pet: Pet, OnCompleted: @escaping (Result <Any, Any>)->()) {
         makeRequest(url: api, method: .put, parameters: pet.toJSON().dictionaryObject, headers: header, OnCompleted: OnCompleted)
    }
    
    func delete(id: Int, OnCompleted: @escaping (Result <Any, Any>)->()) {
        let api = self.api + "/" + String(id)
         makeRequest(url: api, method: .delete, headers: header, OnCompleted: OnCompleted)
    }
    
    func getTypes(OnCompleted: @escaping (Result <Any, Any>)->()) {
        let api  = API.Base + API.AnimalTypes
        makeRequest(url: api, method: .get, headers: header, OnCompleted: OnCompleted)
    }
    
}
