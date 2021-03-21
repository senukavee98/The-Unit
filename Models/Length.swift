//
//  Length.swift
//  The Unit
//
//  Created by user187351 on 3/15/21.
//

import Foundation

class Length {
    var meter: Double
    var kilometer: Double
    var mile : Double
    var centimeter: Double
    var milimeter: Double
    var yard: Double
    var inch: Double
    
    init(meter: Double,kilometer: Double,mile: Double,centimeter: Double,milimeter: Double,yard: Double,inch: Double) {
        self.meter = meter
        self.kilometer = kilometer
        self.mile = mile
        self.centimeter = centimeter
        self.milimeter = milimeter
        self.yard = yard
        self.inch = inch
    }

    func historyView() -> String {
        return "\(self.meter) m | \(self.kilometer) km | \(self.mile) mi | \(self.centimeter) cm | \(self.milimeter) mm | \(self.yard) yd | \(self.inch) in"
    }
}
