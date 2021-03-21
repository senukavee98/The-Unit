//
//  LenghtVC.swift
//  The Unit
//
//  Created by user187351 on 3/14/21.
//

import UIKit

enum lengthUnitConvertions: Int {
    case meter, kilometer, mile, centimeter, milimeter, yard, inch
}

class LenghtVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var customKeyboard: Keyboard!
    
    @IBOutlet weak var meterTxtbox: UITextField!
    @IBOutlet weak var kilometerTxtbox: UITextField!
    @IBOutlet weak var mileTxtbox: UITextField!
    @IBOutlet weak var centimeterTxtbox: UITextField!
    @IBOutlet weak var milimeterTxtbox: UITextField!
    @IBOutlet weak var yardTxtbox: UITextField!
    @IBOutlet weak var inchTxtbox: UITextField!
    
    @IBOutlet weak var meterLbl: UILabel!
    @IBOutlet weak var kilometerLbl: UILabel!
    @IBOutlet weak var mileLbl: UILabel!
    @IBOutlet weak var centimeterLbl: UILabel!
   
    @IBOutlet weak var milimeterLbl: UILabel!
    @IBOutlet weak var yardLbl: UILabel!
    @IBOutlet weak var inchLbl: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var length: Length = Length(meter: 0.0, kilometer: 0.0, mile: 0.0, centimeter: 0.0, milimeter: 0.0, yard: 0.0, inch: 0.0)
    var historyStringArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.assignOnDeligate()
        UserDefaults.standard.setValue(0, forKey: "decimalValue")

        historyStringArray.append(contentsOf: loadDefaultData("LengthHistory"))
        
        customKeyboard.negationButton.isEnabled = false
        
        meterLbl.font = UIFont(name: "OpenSans-Regular", size: 18)
        kilometerLbl.font = UIFont(name: "OpenSans-Regular", size: 18)
        mileLbl.font = UIFont(name: "OpenSans-Regular", size: 18)
        centimeterLbl.font = UIFont(name: "OpenSans-Regular", size: 18)
        milimeterLbl.font = UIFont(name: "OpenSans-Regular", size: 18)
        yardLbl.font = UIFont(name: "OpenSans-Regular", size: 18)
        inchLbl.font = UIFont(name: "OpenSans-Regular", size: 18)

        saveButton.layer.cornerRadius = 10; saveButton.layer.masksToBounds = true; saveButton.titleLabel?.font = UIFont(name: "OpenSans-SemiBold", size: 15)
        saveButton.isEnabled = false
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        let decimalValue = UserDefaults.standard.integer(forKey: "decimalValue") as Int

        switch decimalValue {
        case 1:
            meterTxtbox.text = "\(length.meter.rounded(toPlaces: 2))"
            kilometerTxtbox.text = "\(length.kilometer.rounded(toPlaces: 2))"
            mileTxtbox.text = "\(length.mile.rounded(toPlaces: 2))"
            centimeterTxtbox.text = "\(length.centimeter.rounded(toPlaces: 2))"
            milimeterTxtbox.text = "\(length.milimeter.rounded(toPlaces: 2))"
            yardTxtbox.text = "\(length.yard.rounded(toPlaces: 2))"
            inchTxtbox.text = "\(length.inch.rounded(toPlaces: 2))"

        
        case 2:
            meterTxtbox.text = "\(length.meter.rounded(toPlaces: 3))"
            kilometerTxtbox.text = "\(length.kilometer.rounded(toPlaces: 3))"
            mileTxtbox.text = "\(length.mile.rounded(toPlaces: 3))"
            centimeterTxtbox.text = "\(length.centimeter.rounded(toPlaces: 3))"
            milimeterTxtbox.text = "\(length.milimeter.rounded(toPlaces: 3))"
            yardTxtbox.text = "\(length.yard.rounded(toPlaces: 3))"
            inchTxtbox.text = "\(length.inch.rounded(toPlaces: 3))"
            
        case 3:
            meterTxtbox.text = "\(length.meter.rounded(toPlaces: 4))"
            kilometerTxtbox.text = "\(length.kilometer.rounded(toPlaces: 4))"
            mileTxtbox.text = "\(length.mile.rounded(toPlaces: 4))"
            centimeterTxtbox.text = "\(length.centimeter.rounded(toPlaces: 4))"
            milimeterTxtbox.text = "\(length.milimeter.rounded(toPlaces: 4))"
            yardTxtbox.text = "\(length.yard.rounded(toPlaces: 4))"
            inchTxtbox.text = "\(length.inch.rounded(toPlaces: 4))"
        default:
            return
        }
    }
    

    func assignOnDeligate() {
        meterTxtbox.delegate = self
        kilometerTxtbox.delegate = self
        mileTxtbox.delegate = self
        centimeterTxtbox.delegate = self
        milimeterTxtbox.delegate = self
        yardTxtbox.delegate = self
        inchTxtbox.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        customKeyboard?.activeTextFeild = textField
        textField.inputView = UIView()
    }


    @IBAction func handleValueChange(_ sender: UITextField) {
        guard let textValue = sender.text else {return}
        guard let doubleTextValue = Double(textValue) else {
            meterTxtbox.text = ""
            kilometerTxtbox.text = ""
            mileTxtbox.text = ""
            centimeterTxtbox.text = ""
            milimeterTxtbox.text = ""
            yardTxtbox.text = ""
            inchTxtbox.text = ""
            saveButton.isEnabled = false
            return
            
        }
        saveButton.isEnabled = true

        switch lengthUnitConvertions(rawValue: sender.tag)! {
        case .meter:
            length.meter = doubleTextValue
            length.kilometer = doubleTextValue / 1000
            length.mile = doubleTextValue / 1609
            length.centimeter = doubleTextValue * 100
            length.milimeter = doubleTextValue * 1000
            length.yard = doubleTextValue * 1.094
            length.inch = doubleTextValue * 39.37

            kilometerTxtbox.text = "\(length.kilometer)"
            mileTxtbox.text = "\(length.mile)"
            centimeterTxtbox.text = "\(length.centimeter)"
            milimeterTxtbox.text = "\(length.milimeter)"
            yardTxtbox.text = "\(length.yard)"
            inchTxtbox.text = "\(length.inch)"

        case .kilometer:
            length.kilometer = doubleTextValue
            length.meter = doubleTextValue * 1000
            length.mile = doubleTextValue / 1.609
            length.centimeter = doubleTextValue * 100000
            length.milimeter = doubleTextValue * 1000000
            length.yard = doubleTextValue * 1094
            length.inch = doubleTextValue * 39370
            
            meterTxtbox.text = "\(length.meter)"
            mileTxtbox.text = "\(length.mile)"
            centimeterTxtbox.text = "\(length.centimeter)"
            milimeterTxtbox.text = "\(length.milimeter)"
            yardTxtbox.text = "\(length.yard)"
            inchTxtbox.text = "\(length.inch)"

        case .mile:
            length.mile = doubleTextValue
            length.meter = doubleTextValue * 1609
            length.kilometer = doubleTextValue * 1.609
            length.centimeter = doubleTextValue * 160934
            length.milimeter = doubleTextValue * 1609340000
            length.yard = doubleTextValue * 1760
            length.inch = doubleTextValue * 63360
            
            kilometerTxtbox.text = "\(length.kilometer)"
            meterTxtbox.text = "\(length.meter)"
            centimeterTxtbox.text = "\(length.centimeter)"
            milimeterTxtbox.text = "\(length.milimeter)"
            yardTxtbox.text = "\(length.yard)"
            inchTxtbox.text = "\(length.inch)"

        case .centimeter:
            length.centimeter = doubleTextValue
            length.meter = doubleTextValue / 100
            length.kilometer = doubleTextValue / 100000
            length.mile = doubleTextValue / 160934
            length.milimeter = doubleTextValue * 10
            length.yard = doubleTextValue / 91.44
            length.inch = doubleTextValue / 2.54
            
            kilometerTxtbox.text = "\(length.kilometer)"
            mileTxtbox.text = "\(length.mile)"
            meterTxtbox.text = "\(length.meter)"
            milimeterTxtbox.text = "\(length.milimeter)"
            yardTxtbox.text = "\(length.yard)"
            inchTxtbox.text = "\(length.inch)"

        case .milimeter:
            length.milimeter = doubleTextValue
            length.meter = doubleTextValue / 1000
            length.kilometer = doubleTextValue / 1000000
            length.centimeter = doubleTextValue * 10
            length.mile = doubleTextValue / 1609340000
            length.yard = doubleTextValue / 914
            length.inch = doubleTextValue / 25.4
            
            kilometerTxtbox.text = "\(length.kilometer)"
            mileTxtbox.text = "\(length.mile)"
            centimeterTxtbox.text = "\(length.centimeter)"
            meterTxtbox.text = "\(length.meter)"
            yardTxtbox.text = "\(length.yard)"
            inchTxtbox.text = "\(length.inch)"

        case .yard:
            length.yard = doubleTextValue
            length.meter = doubleTextValue / 1.094
            length.kilometer = doubleTextValue / 1094
            length.centimeter = doubleTextValue * 91.44
            length.mile = doubleTextValue / 1760
            length.milimeter = doubleTextValue * 914
            length.inch = doubleTextValue * 36
            
            kilometerTxtbox.text = "\(length.kilometer)"
            mileTxtbox.text = "\(length.mile)"
            centimeterTxtbox.text = "\(length.centimeter)"
            milimeterTxtbox.text = "\(length.milimeter)"
            meterTxtbox.text = "\(length.meter)"
            inchTxtbox.text = "\(length.inch)"
            

        case .inch:
            length.inch = doubleTextValue
            length.meter = doubleTextValue / 39.37
            length.kilometer = doubleTextValue / 39370
            length.centimeter = doubleTextValue * 2.54
            length.mile = doubleTextValue / 63360
            length.milimeter = doubleTextValue * 914
            length.yard = doubleTextValue / 36
            
            kilometerTxtbox.text = "\(length.kilometer)"
            mileTxtbox.text = "\(length.mile)"
            centimeterTxtbox.text = "\(length.centimeter)"
            milimeterTxtbox.text = "\(length.milimeter)"
            yardTxtbox.text = "\(length.yard)"
            meterTxtbox.text = "\(length.meter)"

        }
    }
    
    func loadDefaultData(_ historyKey: String) -> [String]  {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: historyKey) as? [String] ?? [String]()
    }
    
    
    @IBAction func handleValueSave(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        
        let historyString = length.historyView()
        historyStringArray.append(historyString)
        defaults.setValue(historyStringArray, forKey: "LengthHistory")
        
        showToast(message: "Data Saved !", font: UIFont(name: "OpenSans-Regular", size: 12) ?? .systemFont(ofSize: 12))
    }
    
}
