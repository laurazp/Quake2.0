//
//  ContentView.swift
//  Quake
//
//  Created by Laura Zafra Prat on 7/2/24.
//

import SwiftUI

struct ContentView: View {
    let coordinator = Coordinator()
    
    var body: some View {
        coordinator.makeMainView()
    }
}

#Preview {
    let coordinator = Coordinator()
    
    return ContentView()
        .environmentObject(coordinator)
}
