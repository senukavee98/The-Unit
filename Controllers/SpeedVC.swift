//
//  SpeedVC.swift
//  The Unit
//
//  Created by user187351 on 3/14/21.
//

import UIKit

enum speedUnitConvertions: Int {
    case meterSec, kmHour, mileHour, nauticalMileHour
}

class SpeedVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var customKeyboard: Keyboard!
    
    @IBOutlet weak var meterSecTxtbox: UITextField!
    @IBOutlet weak var kmHourTxtbox: UITextField!
    @IBOutlet weak var mileHourTxtbox: UITextField!
    @IBOutlet weak var nauticalMileHoreTxtbox: UITextField!
    
    @IBOutlet weak var meterSecLbl: UILabel!
    @IBOutlet weak var kmHourLbl: UILabel!
    @IBOutlet weak var mileHourLbl: UILabel!
    @IBOutlet weak var nauticalMileHourLbl: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var speed: Speed = Speed(meterSec: 0.0, kmHour: 0.0, mileHour: 0.0, nauticalMileHour: 0.0)
    
    var historyStringArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.assignOnDeligate()
        
        historyStringArray.append(contentsOf: loadDefaultData("SpeedHistory"))
        customKeyboard.negationButton.isEnabled = false
        
        meterSecLbl.font = UIFont(name: "OpenSans-Regular", size: 18)
        kmHourLbl.font = UIFont(name: "OpenSans-Regular", size: 18)
        mileHourLbl.font = UIFont(name: "OpenSans-Regular", size: 18)
        nauticalMileHourLbl.font = UIFont(name: "OpenSans-Regular", size: 18)
        
        saveButton.layer.cornerRadius = 10; saveButton.layer.masksToBounds = true; saveButton.titleLabel?.font = UIFont(name: "OpenSans-SemiBold", size: 15)
        saveButton.isEnabled = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let decimalValue = UserDefaults.standard.integer(forKey: "decimalValue") as Int
        
        switch decimalValue {
        case 1:
            meterSecTxtbox.text = "\(speed.meterSec.rounded(toPlaces: 2))"
            kmHourTxtbox.text = "\(speed.kmHour.rounded(toPlaces: 2))"
            mileHourTxtbox.text = "\(speed.mileHour.rounded(toPlaces: 2))"
            nauticalMileHoreTxtbox.text = "\(speed.nauticalMileHour.rounded(toPlaces: 2))"
            
        case 2:
            meterSecTxtbox.text = "\(speed.meterSec.rounded(toPlaces: 3))"
            kmHourTxtbox.text = "\(speed.kmHour.rounded(toPlaces: 3))"
            mileHourTxtbox.text = "\(speed.mileHour.rounded(toPlaces: 3))"
            nauticalMileHoreTxtbox.text = "\(speed.nauticalMileHour.rounded(toPlaces: 3))"
            
        case 3:
            meterSecTxtbox.text = "\(speed.meterSec.rounded(toPlaces: 4))"
            kmHourTxtbox.text = "\(speed.kmHour.rounded(toPlaces: 4))"
            mileHourTxtbox.text = "\(speed.mileHour.rounded(toPlaces: 4))"
            nauticalMileHoreTxtbox.text = "\(speed.nauticalMileHour.rounded(toPlaces: 4))"
        default:
            return
        }
    }
    
    func assignOnDeligate() {
        meterSecTxtbox.delegate = self
        kmHourTxtbox.delegate = self
        mileHourTxtbox.delegate = self
        nauticalMileHoreTxtbox.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        customKeyboard?.activeTextFeild = textField
        textField.inputView = UIView()
    }
    
    
    @IBAction func handleValueChange(_ sender: UITextField) {
        
        guard let textValue = sender.text else {return}
        guard let doubleTextValue = Double(textValue) else {
            meterSecTxtbox.text = ""
            kmHourTxtbox.text = ""
            mileHourTxtbox.text = ""
            nauticalMileHoreTxtbox.text = ""
            saveButton.isEnabled = false
            return
            
        }
        saveButton.isEnabled = true
        
        switch speedUnitConvertions(rawValue: sender.tag)! {
        case .meterSec:
            speed.meterSec = doubleTextValue
            speed.kmHour = doubleTextValue * 3.6
            speed.mileHour = doubleTextValue * 2.237
            speed.nauticalMileHour = doubleTextValue * 1.944
            
            kmHourTxtbox.text = "\(speed.kmHour)"
            mileHourTxtbox.text = "\(speed.mileHour)"
            nauticalMileHoreTxtbox.text = "\(speed.nauticalMileHour)"
            
        case .kmHour:
            speed.kmHour = doubleTextValue
            speed.meterSec = doubleTextValue / 3.6
            speed.mileHour = doubleTextValue / 1.609
            speed.nauticalMileHour = doubleTextValue / 1.852
            
            meterSecTxtbox.text = "\(speed.meterSec)"
            mileHourTxtbox.text = "\(speed.mileHour)"
            nauticalMileHoreTxtbox.text = "\(speed.nauticalMileHour)"
            
        case .mileHour:
            speed.mileHour = doubleTextValue
            speed.meterSec = doubleTextValue / 2.237
            speed.kmHour = doubleTextValue * 1.609
            speed.nauticalMileHour = doubleTextValue / 1.151
            
            meterSecTxtbox.text = "\(speed.meterSec)"
            mileHourTxtbox.text = "\(speed.mileHour)"
            nauticalMileHoreTxtbox.text = "\(speed.nauticalMileHour)"
            
        case .nauticalMileHour:
            speed.meterSec = doubleTextValue / 1.944
            speed.kmHour = doubleTextValue * 1.852
            speed.mileHour = doubleTextValue * 1.151
            
            meterSecTxtbox.text = "\(speed.meterSec)"
            kmHourTxtbox.text = "\(speed.kmHour)"
            mileHourTxtbox.text = "\(speed.mileHour)"
        }
    }
    
    func loadDefaultData(_ historyKey: String) -> [String]  {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: historyKey) as? [String] ?? [String]()
    }
    
    @IBAction func handleSave(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        
        let historyString = speed.historyView()
        historyStringArray.append(historyString)
        defaults.setValue(historyStringArray, forKey: "SpeedHistory")
        
        showToast(message: "Data Saved !", font: UIFont(name: "OpenSans-Regular", size: 12) ?? .systemFont(ofSize: 12))
    }
    
    
    
}
