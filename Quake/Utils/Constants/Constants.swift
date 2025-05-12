//
//  Constants.swift
//  Quake
//
//  Created by Laura Zafra Prat on 3/4/25.
//

import UIKit

struct Constants {
    struct Design {
        struct Colors {
            static let Blue = UIColor.systemBlue
            static let DarkGrey = UIColor.darkGray
            static let Mint = UIColor.systemMint
            static let Orange = UIColor.orange
            static let Red = UIColor.red
            static let Green = UIColor.green
        }
        
        struct Dimens {
            static let hugeMargin = 32.0
            static let semiHugeMargin = 26.0
            static let extraLargeMargin = 22.0
            static let largeMargin = 20.0
            static let semiLargeMargin = 16.0
            static let mediumMargin = 12.0
            static let smallMargin = 8.0
            static let extraSmallMargin = 6.0
            
            static let mapDetailHeight = 350.0
            static let settingsRowHeight = 38.0
            static let cardCornerRadius = 8.0
            
            static let imageOpacity = 0.6
            static let shadowOpacity = 0.2
            static let detailsCardOpacity = 0.1
        }
        
        struct Styles {
            // example: static let Body = UIFont.systemFont(ofSize: 16, weight: .regular)
        }
    }
    
    struct Images {
        static let earthquakesListIcon = "house"
        static let mapIcon = "map"
        static let settingsIcon = "wrench.and.screwdriver"
        static let earthquakeMapPinSystemName = "waveform.path.ecg" //pin.fill
        static let unitsSettingsImageName = "option"
        static let locationSettingsImageName = "location"
        static let infoSettingsImageName = "info"
        static let faqSettingsImageName = "questionmark"
        static let feedbackSettingsImageName = "wave.3.backward"
        static let centerLocationIcon = "paperplane"
    }
}
