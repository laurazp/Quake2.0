//
//  GetMagnitudeColorUseCase.swift
//  Quake
//
//  Created by Laura Zafra Prat on 7/2/24.
//

import UIKit
import SwiftUI

struct GetMagnitudeColorUseCase {
    
    func getMagnitudeColor(magnitude: Double) -> Color {
        var magnitudeLevel: Int
        var magnitudeColor: Color
        
        if magnitude < 3 {
            magnitudeLevel = 1
        }
        else if magnitude >= 3 && magnitude < 5 {
            magnitudeLevel = 2
        }
        else {
            magnitudeLevel = 3
        }
        
        switch magnitudeLevel {
        case 1:
            magnitudeColor = .green
        case 2:
            magnitudeColor = .orange
        case 3:
            magnitudeColor = .red
        default:
            magnitudeColor = .blue
        }
        
        return magnitudeColor
    }
}
