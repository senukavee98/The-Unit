//
//  Speed.swift
//  The Unit
//
//  Created by user187351 on 3/15/21.
//

import Foundation

class Speed {
    var meterSec: Double
    var kmHour: Double
    var mileHour: Double
    var nauticalMileHour: Double
    
    init(meterSec: Double, kmHour: Double, mileHour: Double, nauticalMileHour: Double) {
        self.meterSec = meterSec
        self.kmHour = kmHour
        self.mileHour = mileHour
        self.nauticalMileHour = nauticalMileHour
    }

    func historyView() -> String {
        return "\(self.meterSec) meter/sec  |  \(self.kmHour) km/hr  |  \(self.mileHour) mile/hr  |  \(self.nauticalMileHour) knot"
    }
}
