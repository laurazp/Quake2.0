//
//  QuakeApp.swift
//  Quake
//
//  Created by Laura Zafra Prat on 7/2/24.
//

import SwiftUI

@main
struct QuakeApp: App {
    let coordinator = Coordinator()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(coordinator)
        }
    }
}
