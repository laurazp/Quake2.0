//
//  MainView.swift
//  Quake
//
//  Created by Laura Zafra Prat on 9/2/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        TabView {
            coordinator.makeEarthquakesView()
                .tabItem {
                    Label(
                        "earthquakes_title",
                        systemImage: Constants.Images.earthquakesListIcon)
                }
            coordinator.makeMapView()
                .tabItem {
                    Label(
                        "map_title",
                        systemImage: Constants.Images.mapIcon)
                }
            coordinator.makeSettingsView()
                .tabItem {
                    Label(
                        "settings_title",
                        systemImage: Constants.Images.settingsIcon)
                }
        }
    }
}

#Preview {
    let coordinator = Coordinator()
    
    return MainView()
        .environmentObject(coordinator)
}
