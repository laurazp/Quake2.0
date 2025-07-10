//
//  Earthquake.swift
//  Quake
//
//  Created by Laura Zafra Prat on 8/2/24.
//

import Foundation

struct Earthquake: Identifiable, Equatable, Hashable {
    var id: UUID = UUID()
    let fullTitle: String
    let simplifiedTitle: String
    let place: String
    let formattedCoords: String
    let originalCoords: [Float]
    let depth: String
    let date: String
    let originalDate: Date
    let tsunami: String
    let formattedMagnitude: String
    let originalMagnitude: Double
    
    static var example: Earthquake {
        Earthquake(
            fullTitle: "32 km N of Petersville, Alaska",
            simplifiedTitle: "Petersville, Alaska",
            place: "32 km N of Petersville, Alaska",
            formattedCoords: "150.8276W, 62.7884N",
            originalCoords: [-150.8276, 62.7884],
            depth: "87.6km",
            date: "23/01/2024",
            originalDate: Date(timeIntervalSince1970: 1388619763623 / 1000.0),
            tsunami: "No",
            formattedMagnitude: "1.4",
            originalMagnitude: 1.4

        )
    }
}
