//
//  MapView.swift
//  Quake
//
//  Created by Laura Zafra Prat on 11/2/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel: MapViewModel
    @EnvironmentObject var coordinator: Coordinator
    private let getMagnitudeColorUseCase = GetMagnitudeColorUseCase()
    
    @State private var earthquakes: [Earthquake] = []
    @State private var searchResults: [MKMapItem] = []
    @State private var selectedEarthquake: MKMapItem?
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    
    init(viewModel: MapViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Map(position: $cameraPosition, selection: $selectedEarthquake) {
            ForEach(earthquakes) { earthquake in
                Marker(
                    earthquake.simplifiedTitle,
                    systemImage: Constants.Images.earthquakeMapPinSystemName,
                    coordinate: getCoordinate(earthquake: earthquake))
                .tint(getMarkerColor(magnitude: earthquake.originalMagnitude))
            }
            
            // MARK: - Search results
            ForEach(searchResults, id: \.self) { result in
                Marker(item: result)
            }
        }
        .onAppear {
            fetchEarthquakes()
        }
        .mapStyle(.standard)
        .safeAreaInset(edge: .bottom, alignment: .trailing) {
            Button {
                //TODO: animate center on user location ??
                cameraPosition = .region(.userRegion)
            } label: {
                Image(systemName: Constants.Images.centerLocationIcon)
                    .foregroundStyle(.white)
                    .padding(Constants.Design.Dimens.smallMargin)
                    .background(.blue)
                    .clipShape(.rect(cornerRadius: Constants.Design.Dimens.mediumMargin))
                    .padding(.bottom)
                    .padding(.trailing)
            }
        }
        .onChange(of: searchResults) {
            cameraPosition = .automatic //TODO: ¿¿??
        }
        //TODO: revisar dialog error y async
        .errorLoadingListAlertDialog(error: viewModel.error, errorMessage: viewModel.error?.localizedDescription, retryButtonAction: {
            Task {
                fetchEarthquakes()
            }
        })
    }
    
    //TODO: mover funciones a otro lado?
    
    private func getCoordinate(earthquake: Earthquake) -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: Double(earthquake.originalCoords[1]),
            longitude: Double(earthquake.originalCoords[0]))
    }
    
    private func getMarkerColor(magnitude: Double) -> Color {
        return getMagnitudeColorUseCase.getMagnitudeColor(magnitude: magnitude)
    }
    
    private func fetchEarthquakes() {
        Task {
            do {
                earthquakes = try await viewModel.getEarthquakesMarkers()
            } catch {
                //TODO: Handle error appropriately (e.g., display an alert)
                print("Error fetching earthquakes: \(error)")
            }
        }
    }
}

//TODO: modificar con user location o un punto concreto del mapa

extension CLLocationCoordinate2D {
    static var userLocation: CLLocationCoordinate2D {
        return .init(latitude: 25.7602, longitude: -80.1959)
    }
}

extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return .init(center: .userLocation,
                     latitudinalMeters: 2000000,
                     longitudinalMeters: 2000000)
    }
}

#Preview {
    let coordinator = Coordinator()
    return coordinator.makeMapView()
        .environmentObject(coordinator)
}
