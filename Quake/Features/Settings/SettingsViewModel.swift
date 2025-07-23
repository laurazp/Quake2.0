//
//  SettingsViewModel.swift
//  Quake
//
//  Created by Laura Zafra Prat on 23/7/25.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    private let unitsUseCase = UnitsUseCase()
    
    // MARK: UNITS
    func saveSelectedUnit(selectedSegmentIndex: Int) {
        unitsUseCase.saveSelectedUnit(selectedSegmentIndex: selectedSegmentIndex)
    }
    
    func getSelectedUnit() -> String {
        unitsUseCase.getSelectedUnit()
    }
}
