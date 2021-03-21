//
//  RoundOff.swift
//  The Unit
//
//  Created by user187351 on 3/12/21.
//

import UIKit

extension Double {
    
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
