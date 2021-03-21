//
//  Volume.swift
//  The Unit
//
//  Created by user187351 on 3/15/21.
//

import Foundation

class Volume {
    var ukGallon: Double
    var liter: Double
    var ukPint: Double
    var fluidOunce: Double
    var milileter: Double

    init(ukGallon: Double, liter: Double, ukPint: Double, fluidOunce: Double, milileter: Double) {
        self.ukGallon = ukGallon
        self.liter = liter
        self.ukPint = ukPint
        self.fluidOunce = fluidOunce
        self.milileter = milileter
    }
    
    func historyView() -> String {
        return "\(self.ukGallon) gl  |  \(self.liter) l  |  \(self.ukPint) pt  |  \(self.fluidOunce) oz  |  \(self.milileter) ml"
    }
}
