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
//                NavigationStack {
                    VStack(alignment: .leading, spacing: 16) {
                        // EARTHQUAKE DETAILS
                        ForEach([
                            ("Place", earthquake.place),
                            ("Date", earthquake.date),
                            ("Tsunami", earthquake.tsunami),
                            ("Coords", earthquake.formattedCoords),
                            ("Depth", earthquake.depth)
                        ], id: \.0) { title, value in
                            HStack(alignment: .top) {
                                Text("\(title):")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.gray)
                                
                                Text(value)
                            }
                        }
                        
                        // SEE DETAIL BUTTON
                        HStack {
                            Spacer()
                            Button(action: {
                                navigate = true
                            }) {
                                Text("See details")
                                    .foregroundColor(.teal)
                                    .underline(false)
                            }
                            .buttonStyle(.plain)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        
                        // Invisible NavigationLink
                        NavigationLink(destination: EarthquakeDetailView(earthquake: earthquake), isActive: $navigate) {
                            EmptyView()
                        }
                        .hidden()
                    }
                    .padding()
                    .background(Color.teal.opacity(0.1))
                    .cornerRadius(8)
//                }
//                .padding()
//                .background(Color.gray.opacity(0.2))
//                .cornerRadius(8)
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
