//
//  EarthquakeDetailView.swift
//  Quake
//
//  Created by Laura Zafra Prat on 9/2/24.
//

import SwiftUI
import MapKit

struct EarthquakeDetailView: View {
    let earthquake: Earthquake
    let getMagnitudeColorUseCase = GetMagnitudeColorUseCase()
    
    var body: some View {
        let coordinate = CLLocationCoordinate2D(
            latitude: CLLocationDegrees(earthquake.originalCoords[1]),
            longitude: CLLocationDegrees(earthquake.originalCoords[0])
        )
        
        ScrollView {
            VStack(spacing: 32) {
                // TITLE
                Text(earthquake.simplifiedTitle)
                    .font(.title)
                
                // EARTHQUAKE PROPERTIES
                VStack(alignment: .leading, spacing: 16) {
                    ForEach([
                        ("Place", earthquake.place),
                        ("Date", earthquake.date),
                        ("Tsunami", earthquake.tsunami),
                        ("Coords", earthquake.formattedCoords),
                        ("Depth", earthquake.depth),
                        ("Magnitude", earthquake.formattedMagnitude)
                    ], id: \.0) { title, value in
                        HStack {
                            Text("\(title):")
                                .fontWeight(.bold)
                                .foregroundStyle(.gray)
                            
                            Text(value)
                                .foregroundColor(title == "Magnitude" ? Color(getMagnitudeColorUseCase.getMagnitudeColor(magnitude: earthquake.originalMagnitude)) : Color.black)
                                .fontWeight(title == "Magnitude" ? .bold : .regular)
                        }
                    }
                }
                
                // MAP VIEW
                Map(initialPosition: .region(MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.05,
                        longitudeDelta: 0.05)))
                ) {
                    Marker(
                        earthquake.simplifiedTitle,
                        systemImage: Constants.Images.earthquakeMapPinSystemName,
                        coordinate: coordinate)
                    .tint(getMagnitudeColorUseCase.getMagnitudeColor(magnitude: earthquake.originalMagnitude))
                }
                .frame(height: 350)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 4)
                .padding()
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(EdgeInsets(top: 26, leading: 6, bottom: 6, trailing: 6))
        }
    }
}

#Preview {
    EarthquakeDetailView(earthquake: .example)
}
