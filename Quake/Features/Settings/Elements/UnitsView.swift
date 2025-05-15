//
//  UnitsView.swift
//  Quake
//
//  Created by Laura Zafra Prat on 12/5/25.
//

import SwiftUI

struct UnitsView: View {
    @State private var selectedUnit: LengthUnit = .kilometers
    
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
                
                //TODO: Set unit as selected in app
                Picker("settings_units_length", selection: $selectedUnit) {
                    ForEach(LengthUnit.allCases) { unit in
                        Text(unit.localizedLabel)
                            .tag(unit)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.top, 8)
            }
            .padding()
            
            Spacer()
        }
    }
}

#Preview {
    UnitsView()
}
