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
    
    var body: some View {
        DisclosureGroup(
            isExpanded: $isExpanded,
            content: {
                ZStack {
                    NavigationLink(destination: EarthquakeDetailView(earthquake: earthquake)) {
                        EmptyView()
                    }
                    .opacity(0.0)
                    
                    VStack(alignment: .leading) {
                        ForEach([
                            ("Place", earthquake.place),
                            ("Date", earthquake.date),
                            ("Tsunami", earthquake.tsunami),
                            ("Coords", earthquake.formattedCoords),
                            ("Depth", earthquake.depth)
                        ], id: \.0) { title, value in
                            HStack {
                                Text("\(title):")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.gray)
                                
                                Text(value)
                            }
                        }
                    }
                }
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
