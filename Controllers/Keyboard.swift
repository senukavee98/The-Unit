//
//  Keyboard.swift
//  The Unit
//
//  Created by user187351 on 3/1/21.
//

import UIKit

enum keyboardKeyValues: Int {
    case zero, one, two, three, four, five, six, seven, eight, nine, decimal, clear, negation
}

class Keyboard: UIView {
    
    let nibName = "Keyboard"
    var contentView: UIView?
    var activeTextFeild = UITextField()

    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet weak var negationButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        guard let view = loadViewFromNib() else {return}
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        
        //        rounded corners
        oneButton.layer.cornerRadius = 10; oneButton.layer.masksToBounds = true
        twoButton.layer.cornerRadius = 10; twoButton.layer.masksToBounds = true
        threeButton.layer.cornerRadius = 10; threeButton.layer.masksToBounds = true
        fourButton.layer.cornerRadius = 10; fourButton.layer.masksToBounds = true
        fiveButton.layer.cornerRadius = 10; fiveButton.layer.masksToBounds = true
        sixButton.layer.cornerRadius = 10; sixButton.layer.masksToBounds = true
        sevenButton.layer.cornerRadius = 10; sevenButton.layer.masksToBounds = true
        eightButton.layer.cornerRadius = 10; eightButton.layer.masksToBounds = true
        nineButton.layer.cornerRadius = 10; nineButton.layer.masksToBounds = true
        zeroButton.layer.cornerRadius = 10; zeroButton.layer.masksToBounds = true
        dotButton.layer.cornerRadius = 10; dotButton.layer.masksToBounds = true
        negationButton.layer.cornerRadius = 10; negationButton.layer.masksToBounds = true
        clearButton.layer.cornerRadius = 10; clearButton.layer.masksToBounds = true
        
        //        font-family
        oneButton.titleLabel?.font = UIFont(name: "ProzaLibre-SemiBold", size: 35)
        twoButton.titleLabel?.font = UIFont(name: "ProzaLibre-SemiBold", size: 35)
        threeButton.titleLabel?.font = UIFont(name: "ProzaLibre-SemiBold", size: 35)
        fourButton.titleLabel?.font = UIFont(name: "ProzaLibre-SemiBold", size: 35)
        fiveButton.titleLabel?.font = UIFont(name: "ProzaLibre-SemiBold", size: 35)
        sixButton.titleLabel?.font = UIFont(name: "ProzaLibre-SemiBold", size: 35)
        sevenButton.titleLabel?.font = UIFont(name: "ProzaLibre-SemiBold", size: 35)
        eightButton.titleLabel?.font = UIFont(name: "ProzaLibre-SemiBold", size: 35)
        nineButton.titleLabel?.font = UIFont(name: "ProzaLibre-SemiBold", size: 35)
        zeroButton.titleLabel?.font = UIFont(name: "ProzaLibre-SemiBold", size: 35)
        dotButton.titleLabel?.font = UIFont(name: "ProzaLibre-SemiBold", size: 35)
        negationButton.titleLabel?.font = UIFont(name: "ProzaLibre-SemiBold", size: 35)
        clearButton.titleLabel?.font = UIFont(name: "ProzaLibre-SemiBold", size: 35)
        
        
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    
    // get the cusor point
    func getCursorPosition() -> Int {
        guard let selectRange = activeTextFeild.selectedTextRange else {return 0}
        
        return activeTextFeild.offset(from: activeTextFeild.beginningOfDocument, to: selectRange.start)
    }
    
    // set cursor point
    func setCursorPosition(from: Int, offset: Int = 1) {
        if let newPosition = activeTextFeild.position(from:
                                                        activeTextFeild.beginningOfDocument, offset: from + offset) {
            activeTextFeild.selectedTextRange = activeTextFeild.textRange(from: newPosition, to: newPosition)
        }
    }
    
    
    
    @IBAction func handleKeyPress(_ sender: UIButton) {
        
        let cursorPoint = getCursorPosition()
        
        if let typedText = self.activeTextFeild.text {
            switch keyboardKeyValues(rawValue: sender.tag) {
            
            case .decimal:
                if !typedText.contains("."), typedText.count != 0 {
                    activeTextFeild.insertText(".")
                    setCursorPosition(from: cursorPoint)
                }
                
            case .clear:
                if typedText.count != 0 {
                    self.activeTextFeild.text?.remove(at: typedText.index(typedText.startIndex, offsetBy: cursorPoint - 1))
                    
                    if String(typedText[typedText.index(typedText.startIndex, offsetBy: cursorPoint - 1)]) != "." {
                        activeTextFeild.sendActions(for: UIControl.Event.editingChanged)
                    }
                    
                    setCursorPosition(from: cursorPoint, offset: -1)
                    
                }
                
            case .negation:
                if !typedText.contains("-"), typedText.count != 0 {
                    activeTextFeild.text?.insert("-", at: typedText.index(typedText.startIndex, offsetBy: 0))
                    activeTextFeild.sendActions(for: UIControl.Event.editingChanged)
                    setCursorPosition(from: cursorPoint)
                }
                
                
            default:
                activeTextFeild.insertText(String(sender.tag))
                setCursorPosition(from: cursorPoint)
            }
        }
    }
    
}
