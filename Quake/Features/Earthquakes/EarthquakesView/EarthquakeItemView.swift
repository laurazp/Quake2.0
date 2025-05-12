//
//  EarthquakeItemView.swift
//  Quake
//
//  Created by Laura Zafra Prat on 9/2/24.
//

import SwiftUI

struct EarthquakeItemView: View {
    let getMagnitudeColorUseCase = GetMagnitudeColorUseCase()
    let earthquake: Earthquake
    @State var isExpanded: Bool
    @State private var navigate = false
    
    var body: some View {
        DisclosureGroup(
            isExpanded: $isExpanded,
            content: {
                VStack(alignment: .leading, spacing: 16) {
                    // EARTHQUAKE DETAILS
                    ForEach([
                        ("earthquake_place", earthquake.place),
                        ("earthquake_date", earthquake.date),
                        ("earthquake_tsunami", earthquake.tsunami),
                        ("earthquake_coords", earthquake.formattedCoords),
                        ("earthquake_depth", earthquake.depth)
                    ], id: \.0) { key, value in
                        HStack(alignment: .top) {
                            Text(LocalizedStringKey(key))
                                .fontWeight(.bold)
                                .foregroundStyle(.gray)
                            + Text(":")
                            
                            Text(value)
                        }
                    }
                    
                    // SEE DETAIL BUTTON
                    HStack {
                        Spacer()
                        Button(action: {
                            navigate = true
                        }) {
                            Text("settings_see_details")
                                .foregroundColor(.teal)
                                .fontWeight(.semibold)
                                .underline(false)
                        }
                        .buttonStyle(.plain)
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Invisible NavigationLink
                    NavigationLink(destination: EarthquakeDetailView(earthquake: earthquake), isActive: $navigate) {
                        EmptyView()
                    }
                    .hidden()
                }
                .padding(.top, 22)
                .padding(. horizontal, 16)
                .background(Color.teal.opacity(0.1))
                .cornerRadius(8)
            },
            label: {
                HStack (alignment: VerticalAlignment.center, spacing: 12) {
                    Text(earthquake.formattedMagnitude)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color(getMagnitudeColorUseCase.getMagnitudeColor(magnitude: earthquake.originalMagnitude)))
                    
                    Text(earthquake.simplifiedTitle)
                        .font(.title3)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(6)
                .multilineTextAlignment(.center)
            }
        )
        .accentColor(.gray)
    }
}

#Preview {
    EarthquakeItemView(earthquake: .example, isExpanded: false)
}
