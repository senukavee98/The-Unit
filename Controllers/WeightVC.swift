//
//  WeightVC.swift
//  The Unit
//
//  Created by user187351 on 3/1/21.
//

import UIKit

enum weightUnitConvertions : Int {
    case grame, kilgrame, ounce, pounds, stone, stonepounds
}

class WeightVC: UIViewController, UITextFieldDelegate {
    
//    customKeyboard: Keyboard!
    @IBOutlet weak var customKeyboard: Keyboard!
    
    //    UI Lables
    @IBOutlet weak var grameLbl: UILabel!
    @IBOutlet weak var kgLbl: UILabel!
    @IBOutlet weak var ozLbl: UILabel!
    @IBOutlet weak var poundLbl: UILabel!
    @IBOutlet weak var stoneLbl: UILabel!
    @IBOutlet weak var stonePoundLbl: UILabel!
    
    @IBOutlet weak var grameTxtField: UITextField!
    @IBOutlet weak var kgTxtField: UITextField!
    @IBOutlet weak var ozTxtField: UITextField!
    @IBOutlet weak var poundTxtField: UITextField!
    @IBOutlet weak var stoneTxtField: UITextField!
    @IBOutlet weak var stonePoundTxtField: UITextField!
    
//    model object
    var weight : Weight =  Weight(grame: 0.0, kilograme: 0.0, ounce: 0.0, pound: 0.0, stone: 0.0, stonePound: 0.0)
//    save button
    @IBOutlet weak var saveButton: UIButton!
//    history array
    var historyStringArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        disable default key board
        self.assignOnDeligate()
        
//       load history
        historyStringArray.append(contentsOf: loadDefaultData("WeightHistory"))
        
//       set presicion value
        UserDefaults.standard.setValue(0, forKey: "decimalValue")
        
        customKeyboard.negationButton.isEnabled = false
        
//        UI element Styles
        grameLbl.font = UIFont(name: "OpenSans-Regular", size: 18)
        kgLbl.font = UIFont(name: "OpenSans-Regular", size: 18)
        ozLbl.font = UIFont(name: "OpenSans-Regular", size: 18)
        poundLbl.font = UIFont(name: "OpenSans-Regular", size: 18)
        stoneLbl.font = UIFont(name: "OpenSans-Regular", size: 18)
        stonePoundLbl.font = UIFont(name: "OpenSans-Regular", size: 18)
        
        saveButton.layer.cornerRadius = 10; saveButton.layer.masksToBounds = true; saveButton.titleLabel?.font = UIFont(name: "OpenSans-SemiBold", size: 15)
        saveButton.isEnabled = false
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        let decimalValue = UserDefaults.standard.integer(forKey: "decimalValue") as Int

//        round off
        switch decimalValue {
        case 1:
            grameTxtField.text = "\(weight.grame.rounded(toPlaces: 2))"
            kgTxtField.text = "\(weight.kilograme.rounded(toPlaces: 2))"
            ozTxtField.text = "\(weight.ounce.rounded(toPlaces: 2))"
            poundTxtField.text = "\(weight.pound.rounded(toPlaces: 2))"
            stoneTxtField.text = "\(weight.stone.rounded(toPlaces: 2))"
            stonePoundTxtField.text = "\(weight.stonePound.rounded(toPlaces: 2))"
            
        case 2:
            grameTxtField.text = "\(weight.grame.rounded(toPlaces: 3))"
            kgTxtField.text = "\(weight.kilograme.rounded(toPlaces: 3))"
            ozTxtField.text = "\(weight.ounce.rounded(toPlaces: 3))"
            poundTxtField.text = "\(weight.pound.rounded(toPlaces: 3))"
            stoneTxtField.text = "\(weight.stone.rounded(toPlaces: 3))"
            stonePoundTxtField.text = "\(weight.stonePound.rounded(toPlaces: 3))"
            
        case 3:
            grameTxtField.text = "\(weight.grame.rounded(toPlaces: 4))"
            kgTxtField.text = "\(weight.kilograme.rounded(toPlaces: 4))"
            ozTxtField.text = "\(weight.ounce.rounded(toPlaces: 4))"
            poundTxtField.text = "\(weight.pound.rounded(toPlaces: 4))"
            stoneTxtField.text = "\(weight.stone.rounded(toPlaces: 4))"
            stonePoundTxtField.text = "\(weight.stonePound.rounded(toPlaces: 4))"
        default:
            return
        }
        
//        if let grame = UserDefaults.standard.object(forKey: "g")! as? String {
//            grameTxtField.text = grame
//        }
//        if let kilograme = UserDefaults.standard.object(forKey: "kg") as? String {
//            grameTxtField.text! = kilograme
//        }
//        if let ounce = UserDefaults.standard.object(forKey: "oz") as? String {
//            grameTxtField.text! = ounce
//        }
//        if let pound = UserDefaults.standard.object(forKey: "lb") as? String {
//            grameTxtField.text! = pound
//        }
//        if let stone = UserDefaults.standard.object(forKey: "st") as? String {
//            grameTxtField.text! = stone
//        }
//        if let stonePound = UserDefaults.standard.object(forKey: "st-lb") as? String {
//            grameTxtField.text! = stonePound
//        }
    }
    

    
    func assignOnDeligate() {
        grameTxtField.delegate = self
        kgTxtField.delegate = self
        ozTxtField.delegate = self
        poundTxtField.delegate = self
        stoneTxtField.delegate = self
        stonePoundTxtField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        customKeyboard?.activeTextFeild = textField
        textField.inputView = UIView()
    }
    
    @IBAction func handleValueChange(_ sender: UITextField) {
        
        guard let textValue = sender.text else {return}
        guard let doubleTextValue = Double(textValue) else {
            kgTxtField.text = ""
            grameTxtField.text = ""
            ozTxtField.text = ""
            poundTxtField.text = ""
            stoneTxtField.text = ""
            stonePoundTxtField.text = ""
            saveButton.isEnabled = false
            return
            
        }
        saveButton.isEnabled = true

        UserDefaults.standard.setValue(grameTxtField.text!, forKey: "g")
        UserDefaults.standard.setValue(kgTxtField.text!, forKey: "kg")
        UserDefaults.standard.setValue(ozTxtField.text!, forKey: "oz")
        UserDefaults.standard.setValue(poundTxtField.text!, forKey: "lb")
        UserDefaults.standard.setValue(stoneTxtField.text!, forKey: "st")
        UserDefaults.standard.setValue(stonePoundTxtField.text!, forKey: "st-lb")
        
        switch weightUnitConvertions(rawValue: sender.tag)! {
        case .grame:
            
            weight.grame = doubleTextValue
            weight.kilograme = doubleTextValue / 1000
            weight.ounce = (doubleTextValue / 28.35)
            weight.pound = (doubleTextValue / 454)
            weight.stone = floor(weight.kilograme / 6.35029318)
            weight.stonePound = ((weight.kilograme / 6.35029318).truncatingRemainder(dividingBy: 1) * 14)
            
            kgTxtField.text = "\(weight.kilograme)"
            ozTxtField.text = "\(weight.ounce)"
            poundTxtField.text = "\(weight.pound)"
            stoneTxtField.text = "\(weight.stone)"
            stonePoundTxtField.text = "\(weight.stonePound)"
            
        case .kilgrame:
            weight.kilograme = doubleTextValue
            weight.grame = doubleTextValue * 1000
            weight.ounce = doubleTextValue * 35.274
            weight.pound = doubleTextValue * 2.205
            weight.stone = floor(weight.kilograme / 6.35029318)
            weight.stonePound = (weight.kilograme / 6.35029318).truncatingRemainder(dividingBy: 1) * 14
            
            grameTxtField.text = "\(weight.grame)"
            ozTxtField.text = "\(weight.ounce)"
            poundTxtField.text = "\(weight.pound)"
            stoneTxtField.text = "\(weight.stone)"
            stonePoundTxtField.text = "\(weight.stonePound)"
            
        case .ounce:
            weight.ounce = doubleTextValue
            weight.grame = doubleTextValue * 28.35
            weight.kilograme = doubleTextValue / 35.274
            weight.pound = doubleTextValue / 16
            weight.stone = floor(weight.kilograme / 6.35029318)
            weight.stonePound = (weight.kilograme / 6.35029318).truncatingRemainder(dividingBy: 1) * 14
            
            grameTxtField.text = "\(weight.grame)"
            kgTxtField.text = "\(weight.kilograme)"
            poundTxtField.text = "\(weight.pound)"
            stoneTxtField.text = "\(weight.stone)"
            stonePoundTxtField.text = "\(weight.stonePound)"
            
        case .pounds:
            weight.pound = doubleTextValue
            weight.grame = doubleTextValue * 454
            weight.kilograme =  doubleTextValue / 2.205
            weight.ounce = doubleTextValue * 16
            weight.stone = floor(weight.kilograme / 6.35029318)
            weight.stonePound = (weight.kilograme / 6.35029318).truncatingRemainder(dividingBy: 1) * 14
            
            grameTxtField.text = "\(weight.grame)"
            kgTxtField.text = "\(weight.kilograme)"
            ozTxtField.text = "\(weight.ounce)"
            stoneTxtField.text = "\(weight.stone)"
            stonePoundTxtField.text = "\(weight.stonePound)"
            
        case .stonepounds:
            weight.stonePound =  doubleTextValue
            weight.grame = doubleTextValue * 6350
            weight.kilograme = doubleTextValue * 0.4535
            weight.ounce = doubleTextValue * 224
            weight.pound = doubleTextValue * 14
            
            grameTxtField.text = "\(weight.grame)"
            kgTxtField.text = "\(weight.kilograme)"
            ozTxtField.text = "\(weight.ounce)"
            poundTxtField.text = "\(weight.ounce)"
            stoneTxtField.text = "\(weight.stone)"
            
        case .stone:
            weight.stone = doubleTextValue
            weight.grame = doubleTextValue * 6350
            weight.kilograme = doubleTextValue * 6.35
            weight.ounce = doubleTextValue * 224
            weight.pound = doubleTextValue * 14
            
            grameTxtField.text = "\(weight.grame)"
            kgTxtField.text = "\(weight.kilograme)"
            ozTxtField.text = "\(weight.ounce)"
            poundTxtField.text = "\(weight.ounce)"
            stonePoundTxtField.text = "\(weight.stonePound)"
        }
        
        
        
        
    }

    


    
    func loadDefaultData(_ historyKey: String) -> [String]  {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: historyKey) as? [String] ?? [String]()
    }
    
    @IBAction func handleValueSave(_ sender: UIButton) {
        
        let defaults = UserDefaults.standard
        
        let historyString = weight.historyView()
        historyStringArray.append(historyString)
        defaults.setValue(historyStringArray, forKey: "WeightHistory")
        
        showToast(message: "Data Saved !", font: UIFont(name: "OpenSans-Regular", size: 12) ?? .systemFont(ofSize: 12))
        
        
        
    }
    
    
    
}
