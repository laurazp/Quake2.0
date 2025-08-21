//
//  UnitsUseCase.swift
//  Quake
//
//  Created by Laura Zafra Prat on 7/2/24.
//

import Foundation
import UIKit

struct UnitsUseCase {
    
    func saveSelectedUnit(selectedSegmentIndex: Int) {
        if selectedSegmentIndex == 0 {
            UserDefaults.standard.saveUnits(unit: "kilometers")
            print("Kilometers selected")
        } else {
            UserDefaults.standard.saveUnits(unit: "miles")
            print("Miles selected")
        }
    }
    
    func getSelectedUnit() -> String {
        return UserDefaults.standard.retrieveUnits()
    }
    
    func getSelectedLengthUnit() -> LengthUnit {
        let stored = UserDefaults.standard.retrieveUnits()
        return LengthUnit(rawValue: stored) ?? .kilometers
    }
}
