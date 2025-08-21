//
//  GetLocalizedPlaceFormatter.swift
//  Quake
//
//  Created by Laura Zafra Prat on 21/8/25.
//

import Foundation

class GetLocalizedPlaceFormatter {
    
    func getLocalizedPlace(_ place: String, unit: LengthUnit) -> String {
        // Looks for "32 km" or similar pattern (decimals included)
        let regex = try! NSRegularExpression(pattern: #"(\d+(\.\d+)?)\s*km"#, options: [])
        
        let nsRange = NSRange(place.startIndex..., in: place)
        var newPlace = place
        
        // Finds all coincidences in string
        let matches = regex.matches(in: place, options: [], range: nsRange)
        
        for match in matches.reversed() {
            if let range = Range(match.range(at: 1), in: place),
               let kmValue = Double(place[range]) {
                
                let distanceString: String
                switch unit {
                case .miles:
                    let miles = kmValue * 0.621371
                    distanceString = String(format: "%.1f mi", miles) // con 1 decimal
                case .kilometers:
                    distanceString = String(format: "%.1f km", kmValue)
                }
                
                // Replaces only that coincidence in string
                if let fullRange = Range(match.range, in: newPlace) {
                    newPlace.replaceSubrange(fullRange, with: distanceString)
                }
            }
        }
        
        return newPlace
    }
}
