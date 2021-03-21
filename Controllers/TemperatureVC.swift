//
//  TemperatureVC.swift
//  The Unit
//
//  Created by user187351 on 3/14/21.
//

import UIKit

enum temperatureUnitConvertions: Int {
    case celsius, fahrenheit, kelvin
}

class TemperatureVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var customKeyboard: Keyboard!
    
    @IBOutlet weak var celsiusTxtbox: UITextField!
    @IBOutlet weak var fahrenheitTxtbox: UITextField!
    @IBOutlet weak var kelvinTxtbox: UITextField!
    
    @IBOutlet weak var celsiusLbl: UILabel!
    @IBOutlet weak var farenheitLbl: UILabel!
    @IBOutlet weak var kelvinLbl: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var temperature: Temperature = Temperature(celsius: 0.0, fahrenheit: 0.0, kelvin: 0.0)
    
    var historyStringArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.assignDeligate()
        historyStringArray.append(contentsOf: loadDefaultData("TemperatureHistory"))
        
        UserDefaults.standard.setValue(0, forKey: "decimalValue")
        customKeyboard.negationButton.isEnabled = true
        
        celsiusLbl.font = UIFont(name: "OpenSans-Regular", size: 18)
        farenheitLbl.font = UIFont(name: "OpenSans-Regular", size: 18)
        kelvinLbl.font = UIFont(name: "OpenSans-Regular", size: 18)
        
        saveButton.layer.cornerRadius = 10; saveButton.layer.masksToBounds = true; saveButton.titleLabel?.font = UIFont(name: "OpenSans-SemiBold", size: 15)
        saveButton.isEnabled = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let decimalValue = UserDefaults.standard.integer(forKey: "decimalValue") as Int
        
        
        switch decimalValue {
        case 1:
            celsiusTxtbox.text = "\(temperature.celsius.rounded(toPlaces: 2))"
            fahrenheitTxtbox.text = "\(temperature.fahrenheit.rounded(toPlaces: 2))"
            kelvinTxtbox.text = "\(temperature.kelvin.rounded(toPlaces: 2))"
            
        case 2:
            celsiusTxtbox.text = "\(temperature.celsius.rounded(toPlaces: 3))"
            fahrenheitTxtbox.text = "\(temperature.fahrenheit.rounded(toPlaces: 3))"
            kelvinTxtbox.text = "\(temperature.kelvin.rounded(toPlaces: 3))"
            
        case 3:
            celsiusTxtbox.text = "\(temperature.celsius.rounded(toPlaces: 4))"
            fahrenheitTxtbox.text = "\(temperature.fahrenheit.rounded(toPlaces: 4))"
            kelvinTxtbox.text = "\(temperature.kelvin.rounded(toPlaces: 4))"
        default:
            return
        }
    }
    
    func assignDeligate() {
        celsiusTxtbox.delegate = self
        fahrenheitTxtbox.delegate = self
        kelvinTxtbox.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        customKeyboard?.activeTextFeild = textField
        textField.inputView = UIView()
    }
    
    
    
    @IBAction func handleValueChange(_ sender: UITextField) {
        
        guard let textValue = sender.text else {return}
        guard let doubleTextValue = Double(textValue) else {
            celsiusTxtbox.text = ""
            fahrenheitTxtbox.text = ""
            kelvinTxtbox.text = ""
            saveButton.isEnabled = false
            return}
        saveButton.isEnabled = true
        
        
        
        switch temperatureUnitConvertions(rawValue: sender.tag)! {
        case .celsius:
            temperature.celsius = doubleTextValue
            temperature.fahrenheit = (doubleTextValue * 9/5) + 32
            temperature.kelvin = doubleTextValue + 273.15
            
            fahrenheitTxtbox.text = "\(temperature.fahrenheit)"
            kelvinTxtbox.text = "\(temperature.kelvin)"
            
        case .fahrenheit:
            temperature.fahrenheit = doubleTextValue
            temperature.celsius = (doubleTextValue - 32) * 5/9
            temperature.kelvin = ((doubleTextValue - 32) * 5/9) + 255.372
            
            celsiusTxtbox.text = "\(temperature.celsius)"
            kelvinTxtbox.text = "\(temperature.kelvin)"
            
        case .kelvin:
            temperature.kelvin = doubleTextValue
            temperature.celsius = doubleTextValue - 273.15
            temperature.fahrenheit = ((doubleTextValue - 273.15) * 9/5) + 32
            
            celsiusTxtbox.text = "\(temperature.celsius)"
            fahrenheitTxtbox.text = "\(temperature.fahrenheit)"
            
            
        }
        
    }
    
    
    func loadDefaultData(_ historyKey: String) -> [String]  {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: historyKey) as? [String] ?? [String]()
    }
    
    @IBAction func handleSave(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        
        let historyString = temperature.historyView()
        historyStringArray.append(historyString)
        defaults.setValue(historyStringArray, forKey: "TemperatureHistory")
        
        showToast(message: "Data Saved !", font: UIFont(name: "OpenSans-Regular", size: 12) ?? .systemFont(ofSize: 12))
    }
    
}
