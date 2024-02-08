//
//  Double.swift
//  Quake
//
//  Created by Laura Zafra Prat on 8/2/24.
//

import Foundation

extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
