//
//  Coordinator.swift
//  Quake
//
//  Created by Laura Zafra Prat on 7/2/24.
//

import Foundation

class Coordinator: ObservableObject {
    private let earthquakesRepository: EarthquakesRepository
    private let getEarthquakesUseCase: GetEarthquakesUseCase
    
    init() {
        let networkClient = URLSessionNetworkClient()
        
        // MARK: - Earthquakes
        let earthquakesRemoteService = EarthquakesRemoteService(networkClient: networkClient)
        self.earthquakesRepository = EarthquakesRepository(remoteService: earthquakesRemoteService)
        self.getEarthquakesUseCase = GetEarthquakesUseCase(earthquakesRepository: earthquakesRepository)
    }
    
    // MARK: - MainView
    func makeMainView() -> MainView {
        MainView()
    }
    
    // MARK: - EarthquakesView
    func makeEarthquakesView() -> EarthquakesView {
        EarthquakesView(viewModel: makeEarthquakesViewModel())
    }
    
    func makeEarthquakeView(for earthquake: Earthquake) -> EarthquakeDetailView {
        EarthquakeDetailView(earthquake: earthquake)
    }
    
    // MARK: - MapView
    func makeMapView() -> MapView {
        MapView(viewModel: makeMapViewModel())
    }
    
    // MARK: - SettingsView
    func makeSettingsView() -> SettingsView {
        SettingsView(/*viewModel: makeSettingsViewModel()*/)
    }
    
    // MARK: Viewmodels
    private func makeEarthquakesViewModel() -> EarthquakesViewModel {
        return EarthquakesViewModel(getEarthquakesUseCase: getEarthquakesUseCase)
    }
    
    private func makeMapViewModel() -> MapViewModel {
        return MapViewModel(getEarthquakesUseCase: getEarthquakesUseCase)
    }
}
