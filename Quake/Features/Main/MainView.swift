//
//  MainView.swift
//  Quake
//
//  Created by Laura Zafra Prat on 9/2/24.
//

import SwiftUI

struct MainView: View {
    private struct Layout {
        static let earthquakesListTitle = "Earthquakes"
        static let mapTitle = "Map"
        static let settingsTitle = "Settings"
        static let earthquakesListIcon = "house"
        static let mapIcon = "map"
        static let settingsIcon = "wrench.and.screwdriver"
    }
    
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        TabView {
            coordinator.makeEarthquakesView()
                .tabItem {
                    Label(
                        Layout.earthquakesListTitle,
                        systemImage: Layout.earthquakesListIcon)
                }
            coordinator.makeMapView()
                .tabItem {
                    Label(
                        Layout.mapTitle,
                        systemImage: Layout.mapIcon)
                }
            coordinator.makeSettingsView()
                .tabItem {
                    Label(
                        Layout.settingsTitle,
                        systemImage: Layout.settingsIcon)
                }
        }
    }
}

#Preview {
    let coordinator = Coordinator()
    
    return MainView()
        .environmentObject(coordinator)
}
