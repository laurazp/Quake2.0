//
//  MapViewModel.swift
//  Quake
//
//  Created by Laura Zafra Prat on 12/2/24.
//

import SwiftUI
import MapKit

class MapViewModel: ObservableObject {
    
    private let getEarthquakesUseCase: GetEarthquakesUseCase
    @Published var earthquakes = [Earthquake]()
    @Published var isFiltering = false
    @Published var isLoading = false
    @Published var error: Error?
    
    @Binding var searchResults: [MKMapItem]
    
    init(getEarthquakesUseCase: GetEarthquakesUseCase, searchResults: Binding<[MKMapItem]> = .constant([])) {
        self.getEarthquakesUseCase = getEarthquakesUseCase
        _searchResults = searchResults
    }
    
    @MainActor
    func getEarthquakesMarkers() async throws -> [Earthquake] {
        error = nil
        isLoading = true //TODO: se está usando?
        
        do {
            earthquakes = try await getEarthquakesUseCase.getLatestEarthquakes(offset: 1, pageSize: 2000)
            isLoading = false
            return earthquakes
        } catch(let error) {
            self.error = error
            return []
        }
        
    }
    
    //TODO: modificar para mostrar resultados de búsqueda
    func search(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(
            center: .userLocation,
            span: MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125))
        
        Task {
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        }
    }
}
