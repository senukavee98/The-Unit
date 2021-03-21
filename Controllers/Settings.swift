//
//  Settings.swift
//  The Unit
//
//  Created by user187351 on 3/17/21.
//

import UIKit

class Settings: UIViewController {
    
    
    @IBOutlet weak var decimalTwo: UIButton!
    @IBOutlet weak var decimalThree: UIButton!
    @IBOutlet weak var decimalFour: UIButton!
    
    var radioController: RadioButtonController = RadioButtonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        decimalTwo.layer.cornerRadius = 30; decimalTwo.layer.masksToBounds = true
        decimalThree.layer.cornerRadius = 30; decimalThree.layer.masksToBounds = true
        decimalFour.layer.cornerRadius = 30; decimalFour.layer.masksToBounds = true
        
        radioController.buttonsArray = [decimalTwo, decimalThree, decimalFour]
        
    }
    
    
    
    
    @IBAction func handleValuePress(_ sender: UIButton) {
        radioController.buttonArrayUpdated(buttonSelected: sender)
        UserDefaults.standard.setValue(sender.tag, forKey: "decimalValue")
        
        let cyan = UIColor(red: 28.0/255.0 , green: 211.0/255.0, blue: 218.0/255.0, alpha: 1.0)
        let darkBlue = UIColor(red: 37.0/255.0, green: 41.0/255.0, blue: 52.0/255.0, alpha: 1.0)
        
        
        if sender.tag == 1 {
            decimalTwo.layer.backgroundColor =  cyan.cgColor
            decimalThree.layer.backgroundColor = darkBlue.cgColor
            decimalFour.layer.backgroundColor = darkBlue.cgColor
            
        } else if sender.tag == 2 {
            decimalTwo.layer.backgroundColor = darkBlue.cgColor
            decimalThree.layer.backgroundColor = cyan.cgColor
            decimalFour.layer.backgroundColor = darkBlue.cgColor
            
        } else {
            decimalTwo.layer.backgroundColor = darkBlue.cgColor
            decimalThree.layer.backgroundColor = darkBlue.cgColor
            decimalFour.layer.backgroundColor = cyan.cgColor
        }
        
    }
    
}
