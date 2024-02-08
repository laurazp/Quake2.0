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
            UserDefaults.standard.set("kilometers", forKey: "units")
            print("Kilometers selected")
        } else {
            UserDefaults.standard.set("miles", forKey: "units")
            print("Miles selected")
        }
    }
    
    func getSelectedUnit() -> String {
        return UserDefaults.standard.string(forKey: "units") ?? "kilometers"
    }
}
