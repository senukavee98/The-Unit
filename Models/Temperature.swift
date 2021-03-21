//
//  Temperature.swift
//  The Unit
//
//  Created by user187351 on 3/15/21.
//

import Foundation

class Temperature {
    var celsius: Double
    var fahrenheit: Double
    var kelvin: Double
    
    init(celsius: Double, fahrenheit: Double, kelvin: Double) {
        self.celsius = celsius
        self.fahrenheit = fahrenheit
        self.kelvin = kelvin
    }
    
    func historyView() -> String {
        return "\(self.celsius) C°  |  \(self.fahrenheit) F  | \(self.kelvin) K"
    }
}
