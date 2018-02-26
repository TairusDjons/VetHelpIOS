//
//  EditPetViewController.swift
//  VetHelpIOS
//
//  Created by VetDev1 on 26.02.2018.
//  Copyright © 2018 VetDev1. All rights reserved.
//

import UIKit
import SwiftyJSON
class EditPetViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case pickerViews[0]:
            return types.count
        case pickerViews[1]:
            return breeds.count
        case pickerViews[2]:
            return sex.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case pickerViews[0]:
            editViews[1].text = types[row].name
            breeds = types[row].breeds
            editViews[2].text = ""
            pet?.type = types[row]
        case pickerViews[1]:
            editViews[2].text = breeds[row].name
            pet?.breed = breeds[row]
        case pickerViews[2]:
            editViews[3].text = sex[row]
            pet?.sex = row
        default:
            return
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case pickerViews[0]:
            return types[row].name
        case pickerViews[1]:
            return breeds[row].name
        case pickerViews[2]:
            return sex[row]
        default:
            return "None"
        }
    }
    
    
    
    @IBOutlet weak var sendButton: UIBarButtonItem!
    @IBAction func sendOnTap(_ sender: Any) {
        UserPetService.shared.put(pet: pet!) {
            result in
            switch result {
            case .success(let value):
                self.alertMessage(usrMessage: "Питомец успешно изменен")
            case .error(let value):
                self.alertMessage(usrMessage: "Не удалось изменить питомца")
            }
        }
        enableButtons(editOn: true, sendOn: false, viewOn: false)
        setColor(color: Colors.unableColor)
    }
    @IBOutlet weak var editButton: UIButton!
    
    @IBAction func editOnTap(_ sender: Any) {
        enableButtons(editOn: false, sendOn: true, viewOn: true)
        setColor(color: Colors.defColor)
    }
    @IBOutlet var editViews: [UITextField]!
    var pickerViews = Array(repeating: UIPickerView(), count: 3)
    
    var types = [AnimalType]()
    var breeds = [Breed]()
    let sex = [1: "Мужской", 2:"Женский"]
    var pet: Pet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTypesAndBreeds()
        
        
        for i in 0...pickerViews.count-1 {
            let picker = UIPickerView()
            picker.delegate = self
            picker.dataSource = self
            pickerViews[i] = picker
            editViews[i+1].inputView = picker
        }
        
        setViews()
        // Do any additional setup after loading the view.
    }
    
    func setViews() {
        editViews[0].text = pet?.name
        editViews[1].text = pet?.type.name
        editViews[2].text = pet?.breed.name
        editViews[3].text = sex[(pet?.sex)!]
        editViews[4].text = pet?.birthDate
    }
    
    func enableButtons (editOn: Bool, sendOn: Bool, viewOn: Bool) {
        for view in editViews {
            view.isEnabled = viewOn
        }
        editButton.isEnabled = editOn
        sendButton.isEnabled = sendOn
        
    }
    
    func setColor(color: UIColor) {
        for view in editViews {
            view.backgroundColor = color
        }
    }

    func getTypesAndBreeds() {
        UserPetService.shared.getTypes() { result in
            switch result {
            case .success(let value):
                let json = JSON(value)
                for (index,subJson) in json {
                    let type = AnimalType(json: subJson)
                    self.types.append(type!)
                }
                if let type = self.types.first(where:{ $0.id == self.pet?.breed.animalTypeId}) {
                    self.breeds = type.breeds
                }
                
            case .error(let value):
                self.alertMessage(usrMessage: "Нестабильное соединение")
            
        }
        }
    }
    
    
    
    func alertMessage(usrMessage: String, usrHandler: ((UIAlertAction)->Void)? = nil) {
        let alert = UIAlertController(title: "Alert", message: usrMessage, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
