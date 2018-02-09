//
//  StartDiagnosticController.swift
//  VetHelpIOS
//
//  Created by VetDev1 on 24.01.2018.
//  Copyright © 2018 VetDev1. All rights reserved.
//

import UIKit

class StartDiagnosticController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var petNameField: UITextField!
    @IBOutlet weak var petTypePicker: UIPickerView!
    @IBOutlet weak var petBreedPicker: UIPickerView!
    @IBOutlet weak var petSexPicker: UIPickerView!
    @IBOutlet weak var petBirthDatePicker: UIDatePicker!
    
    @IBAction func createAndStartOnTap(_ sender: Any) {
        
    }
    
    @IBAction func chooseAndStartOnTap(_ sender: Any) {
        if OAuth.oauth2.hasUnexpiredAccessToken() == false {
            
        }
    }
    
    let testTypes = ["cat", "dog", "hamster"]
    let testBreeds = ["someBreed", "anotherBreed"]
    let sex = ["мужской", "женский"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case petTypePicker:
            return testTypes.count
        case petBreedPicker:
            return testBreeds.count
        case petSexPicker:
            return sex.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        switch pickerView {
        case petTypePicker:
            return testTypes[row]
        case petBreedPicker:
            return testBreeds[row]
        case petSexPicker:
            return sex[row]
        default:
            return "nil"
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
