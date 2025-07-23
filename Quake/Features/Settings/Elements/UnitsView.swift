//
//  UnitsView.swift
//  Quake
//
//  Created by Laura Zafra Prat on 12/5/25.
//

import SwiftUI

struct UnitsView: View {
    @State private var selectedUnit: LengthUnit = .kilometers
    @StateObject private var settingsViewModel: SettingsViewModel
    
    init(settingsViewModel: SettingsViewModel = SettingsViewModel()) {
        _settingsViewModel = StateObject(wrappedValue: settingsViewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text(LocalizedStringKey("settings_units"))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(alignment: .center)
                    .padding(.top)
                Spacer()
            }
            
            VStack(alignment: .leading) {
                Text("settings_units_length")
                    .font(.headline)
                
                Picker("settings_units_length", selection: $selectedUnit) {
                    ForEach(LengthUnit.allCases) { unit in
                        Text(unit.localizedLabel)
                            .tag(unit)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.top, 8)
                .onChange(of: selectedUnit) {
                    settingsViewModel.saveSelectedUnit(selectedSegmentIndex: selectedUnit.index)
                }
            }
            .padding()
            
            Spacer()
        }
        .onAppear {
            /// Get UserDefaults selected unit value
            selectedUnit = LengthUnit(rawValue: settingsViewModel.getSelectedUnit()) ?? .kilometers
        }
    }
}

#Preview {
    UnitsView()
}
