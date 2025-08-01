//
//  MapView.swift
//  Quake
//
//  Created by Laura Zafra Prat on 11/2/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var locationManager = LocationPermissionManager()
    @StateObject private var viewModel: MapViewModel
    @EnvironmentObject var coordinator: Coordinator
    private let getMagnitudeColorUseCase = GetMagnitudeColorUseCase()
    
    @State private var earthquakes: [Earthquake] = []
    @State private var searchResults: [MKMapItem] = []
    @State private var selectedEarthquake: Earthquake?
    @State private var showDetailCard = false
    @State private var navigateToDetail = false
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    
    init(viewModel: MapViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    //TODO: Centrar en ubicación del usuario si hay permisos
    //TODO: Implementar click en los markers (puede no parpadear el botón?)
    //TODO: Intentar colocar el button justo encima del marker
    
    var body: some View {
        NavigationStack {
            ZStack {
                // MAP
                MapReader { proxy in
                    Map(position: $cameraPosition, selection: $selectedEarthquake) {
                        ForEach(earthquakes) { earthquake in
                            Marker(
                                earthquake.simplifiedTitle,
                                systemImage: Constants.Images.earthquakeMapPinSystemName,
                                coordinate: getCoordinate(earthquake: earthquake))
                            .tint(getMarkerColor(magnitude: earthquake.originalMagnitude))
                            .tag(earthquake)
                        }
                        
                        // MARK: - Search results
                        ForEach(searchResults, id: \.self) { result in
                            Marker(item: result)
                        }
                    }
                    .onAppear {
                        if !locationManager.isAuthorized && !locationManager.isDenied {
                            locationManager.requestPermission()
                        }
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
                    //TODO: ¿¿??
//                    .onChange(of: searchResults) {
//                        cameraPosition = .automatic
//                    }
                    .overlay(alignment: .topLeading) {
                        if let earthquake = selectedEarthquake {
                            Button(action: {
                                //TODO: Navigate to detail
                                print(earthquake.simplifiedTitle)
                                navigateToDetail = true
//                                coordinator.makeEarthquakeView(for: earthquake)
                            }) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(earthquake.simplifiedTitle)
                                        .font(.headline)
                                    Text("Magnitud: \(String(format: "%.1f", earthquake.originalMagnitude))")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                .padding(8)
                                .background(.ultraThinMaterial)
                                .cornerRadius(12)
                                .shadow(radius: 4)
                            }
                            //TODO: .offset(getCardOffset(for: earthquake, proxy: proxy))
                        }
                    }
                    //TODO: revisar dialog error y async
                    .errorLoadingListAlertDialog(error: viewModel.error, errorMessage: viewModel.error?.localizedDescription, retryButtonAction: {
                        Task {
                            fetchEarthquakes()
                        }
                    })
                    
                    // Overlay if location permissions are denied
                    if locationManager.isDenied {
                        VStack {
                            Spacer()
                            Text("map_location_permissions")
                                .multilineTextAlignment(.center)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(radius: 4)
                                .padding()
                        }
                    }
                }
                .navigationDestination(for: Earthquake.self) { selectedEarthquake in
                    EarthquakeDetailView(earthquake: selectedEarthquake)
                }
                
                if let earthquake = selectedEarthquake {
                    NavigationLink(
                        destination: EarthquakeDetailView(earthquake: earthquake),
                        isActive: $navigateToDetail
                    ) {
                        EmptyView()
                    }
                    .hidden()
                }
            }
        }
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
    
    //TODO: Revisar para colocar button o borrar
    private func getCardOffset(for earthquake: Earthquake, proxy: MapProxy) -> CGSize {
        let coordinate = CLLocationCoordinate2D(
            latitude: CLLocationDegrees(earthquake.originalCoords[1]),
            longitude: CLLocationDegrees(earthquake.originalCoords[0])
        )
        let point = proxy.convert(coordinate, to: .local)
        return CGSize(width: point?.x ?? 0, height: (point?.y ?? 0) - 60)
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
