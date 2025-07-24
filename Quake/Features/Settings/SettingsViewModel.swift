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
    
    /// Message variables
    @Published var selectedType: MessageType = .request
    @Published var selectedImage: UIImage?
    @Published var messageText: String = ""
    @Published var appName: String = ""
    @Published var appVersion: String = ""
    @Published var appBuild: String = ""
    @Published var deviceModel: String = ""
    @Published var deviceSystemVersion: String = ""
    
    // MARK: UNITS
    func saveSelectedUnit(selectedSegmentIndex: Int) {
        unitsUseCase.saveSelectedUnit(selectedSegmentIndex: selectedSegmentIndex)
    }
    
    func getSelectedUnit() -> String {
        unitsUseCase.getSelectedUnit()
    }
    
    // MARK: FEEDBACK
    func loadAppInfo() {
        deviceSystemVersion = UIDevice.current.systemVersion
        deviceModel = UIDevice.current.model
        appName = String(localized: LocalizedStringResource("quake_app_name"))
        appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "N/A"
        appBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "N/A"
    }
}
