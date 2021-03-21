//
//  Weight.swift
//  The Unit
//
//  Created by user187351 on 3/1/21.
//

import Foundation

class Weight {
    var grame: Double
    var kilograme: Double
    var ounce: Double
    var pound: Double
    var stone: Double
    var stonePound: Double
    
    init(grame: Double,kilograme: Double, ounce: Double, pound: Double, stone: Double, stonePound: Double) {
        self.grame = grame
        self.kilograme = kilograme
        self.ounce = ounce
        self.pound = pound
        self.stone = stone
        self.stonePound = stonePound
    }
    
    func historyView() -> String {
        return "\(self.grame) g  |  \(self.kilograme) kg  |  \(self.ounce) oz  |  \(self.pound) lb  |  \(self.stone) st  \(self.stonePound) lb"
    }
    
}
