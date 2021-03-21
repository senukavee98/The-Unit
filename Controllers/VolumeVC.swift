//
//  VolumeVC.swift
//  The Unit
//
//  Created by user187351 on 3/14/21.
//

import UIKit

enum volumeUnitConversions: Int {
    case ukGallon, liter, ukPint, fluidOunce, milileter
}
class VolumeVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var cutomKeyboard: Keyboard!
    
    @IBOutlet weak var ukGallonTxtbox: UITextField!
    @IBOutlet weak var literTxtbox: UITextField!
    @IBOutlet weak var ukPintTxtbox: UITextField!
    @IBOutlet weak var ounceTxtbox: UITextField!
    @IBOutlet weak var milileterTxtbox: UITextField!
    
    @IBOutlet weak var ukGallonLbl: UILabel!
    @IBOutlet weak var literLbl: UILabel!
    @IBOutlet weak var ukPintLbl: UILabel!
    @IBOutlet weak var ounceLbl: UILabel!
    @IBOutlet weak var milileterLbl: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var volume: Volume = Volume(ukGallon: 0.0, liter: 0.0, ukPint: 0.0, fluidOunce: 0.0, milileter: 0.0)
    var historyStringArray: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.assignOnDeligate()

        historyStringArray.append(contentsOf: loadDefaultData("VolumeHistory"))
        cutomKeyboard.negationButton.isEnabled = false

        
        ukGallonLbl.font = UIFont(name: "OpenSans-Regular", size: 18)
        literLbl.font = UIFont(name: "OpenSans-Regular", size: 18)
        ukPintLbl.font = UIFont(name: "OpenSans-Regular", size: 18)
        ounceLbl.font = UIFont(name: "OpenSans-Regular", size: 18)
        milileterLbl.font = UIFont(name: "OpenSans-Regular", size: 18)
        
        saveButton.layer.cornerRadius = 10; saveButton.layer.masksToBounds = true; saveButton.titleLabel?.font = UIFont(name: "OpenSans-SemiBold", size: 15)
        saveButton.isEnabled = false

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let decimalValue = UserDefaults.standard.integer(forKey: "decimalValue") as Int
                
        switch decimalValue {
        case 1:
            ukGallonTxtbox.text = "\(volume.ukGallon.rounded(toPlaces: 2))"
            literTxtbox.text = "\(volume.liter.rounded(toPlaces: 2))"
            ukPintTxtbox.text = "\(volume.ukPint.rounded(toPlaces: 2))"
            ounceTxtbox.text = "\(volume.fluidOunce.rounded(toPlaces: 2))"
            milileterTxtbox.text = "\(volume.milileter.rounded(toPlaces: 2))"
        
        case 2:
            ukGallonTxtbox.text = "\(volume.ukGallon.rounded(toPlaces: 3))"
            literTxtbox.text = "\(volume.liter.rounded(toPlaces: 3))"
            ukPintTxtbox.text = "\(volume.ukPint.rounded(toPlaces: 3))"
            ounceTxtbox.text = "\(volume.fluidOunce.rounded(toPlaces: 3))"
            milileterTxtbox.text = "\(volume.milileter.rounded(toPlaces: 3))"
            
        case 3:
            ukGallonTxtbox.text = "\(volume.ukGallon.rounded(toPlaces: 4))"
            literTxtbox.text = "\(volume.liter.rounded(toPlaces: 4))"
            ukPintTxtbox.text = "\(volume.ukPint.rounded(toPlaces: 4))"
            ounceTxtbox.text = "\(volume.fluidOunce.rounded(toPlaces: 4))"
            milileterTxtbox.text = "\(volume.milileter.rounded(toPlaces: 4))"
        default:
            return
        }
    }

    func assignOnDeligate() {
        ukGallonTxtbox.delegate = self
        literTxtbox.delegate = self
        ukPintTxtbox.delegate = self
        ounceTxtbox.delegate = self
        milileterTxtbox.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        cutomKeyboard?.activeTextFeild = textField
        textField.inputView = UIView()
    }


    @IBAction func handleValueChange(_ sender: UITextField) {
        guard let textValue = sender.text else {return}
        guard let doubleTextValue = Double(textValue) else {
            ukGallonTxtbox.text = ""
            literTxtbox.text = ""
            ukPintTxtbox.text = ""
            ounceTxtbox.text = ""
            milileterTxtbox.text = ""
            saveButton.isEnabled = false
            return
            
        }
        saveButton.isEnabled = true

        
        switch volumeUnitConversions(rawValue: sender.tag)! {
        case .ukGallon:
            volume.ukGallon = doubleTextValue
            volume.liter = doubleTextValue * 4.546
            volume.ukPint = doubleTextValue * 8
            volume.fluidOunce = doubleTextValue * 154
            volume.milileter = doubleTextValue * 4546
            
            literTxtbox.text = "\(volume.liter)"
            ukPintTxtbox.text = "\(volume.ukPint)"
            ounceTxtbox.text = "\(volume.fluidOunce)"
            milileterTxtbox.text = "\(volume.milileter)"

        case .liter:
            volume.liter = doubleTextValue
            volume.ukGallon = doubleTextValue / 4.546
            volume.ukPint = doubleTextValue * 1.76
            volume.fluidOunce = doubleTextValue * 33.814
            volume.milileter = doubleTextValue * 1000
            
            ukGallonTxtbox.text = "\(volume.ukGallon)"
            ukPintTxtbox.text = "\(volume.ukPint)"
            ounceTxtbox.text = "\(volume.fluidOunce)"
            milileterTxtbox.text = "\(volume.milileter)"
            
            
        case .ukPint:
            volume.ukPint = doubleTextValue
            volume.ukGallon = doubleTextValue / 8
            volume.liter = doubleTextValue / 1.76
            volume.fluidOunce = doubleTextValue * 19.215
            volume.milileter = doubleTextValue * 568
            
            ukGallonTxtbox.text = "\(volume.ukGallon)"
            literTxtbox.text = "\(volume.liter)"
            ounceTxtbox.text = "\(volume.fluidOunce)"
            milileterTxtbox.text = "\(volume.milileter)"
            
        case .fluidOunce:
            volume.fluidOunce = doubleTextValue
            volume.ukGallon = doubleTextValue / 154
            volume.ukPint = doubleTextValue / 19.215
            volume.liter = doubleTextValue / 33.814
            volume.milileter = doubleTextValue * 29.574
            
            ukGallonTxtbox.text = "\(volume.ukGallon)"
            ukPintTxtbox.text = "\(volume.ukPint)"
            literTxtbox.text = "\(volume.liter)"
            milileterTxtbox.text = "\(volume.milileter)"
            
        case .milileter:
            volume.milileter = doubleTextValue
            volume.ukGallon = doubleTextValue / 4546
            volume.ukPint = doubleTextValue / 568
            volume.fluidOunce = doubleTextValue / 29.574
            volume.liter = doubleTextValue / 1000
            
            ukGallonTxtbox.text = "\(volume.ukGallon)"
            ukPintTxtbox.text = "\(volume.ukPint)"
            ounceTxtbox.text = "\(volume.fluidOunce)"
            literTxtbox.text = "\(volume.liter)"
        }


    }
    
    func loadDefaultData(_ historyKey: String) -> [String]  {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: historyKey) as? [String] ?? [String]()
    }
    
    
    @IBAction func handleSave(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        
        let historyString = volume.historyView()
        historyStringArray.append(historyString)
        defaults.setValue(historyStringArray, forKey: "VolumeHistory")
        
        showToast(message: "Data Saved !", font: UIFont(name: "OpenSans-Regular", size: 12) ?? .systemFont(ofSize: 12))
    }
    
}
