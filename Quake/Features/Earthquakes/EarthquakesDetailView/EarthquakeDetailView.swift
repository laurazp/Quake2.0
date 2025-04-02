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
    
    @State var region = MKCoordinateRegion(
        center: .init(latitude: 37.334_900,longitude: -122.009_020),
        span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    var body: some View {
        VStack(spacing: 32) {
            Text(earthquake.simplifiedTitle)
                .font(.title)
            
            VStack(alignment: .leading, spacing: 16) {
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
            
            //TODO: MapView
            ZStack {
                Rectangle()
                    .frame(height: 350)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                //.shadow(color: colorScheme == .dark ? Color.gray : Color.black, radius: 5, x: 3, y: 2)
                    .padding(12)
                Map(initialPosition: .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: CLLocationDegrees(earthquake.originalCoords[1]), longitude: CLLocationDegrees(earthquake.originalCoords[0])), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
                )
                .frame(height: 350)
                .padding()
                .edgesIgnoringSafeArea(.all)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(EdgeInsets(top: 26, leading: 6, bottom: 6, trailing: 6))
    }
}

#Preview {
    EarthquakeDetailView(earthquake: .example)
}
