//
//  LengthUnit.swift
//  Quake
//
//  Created by Laura Zafra Prat on 15/5/25.
//

import SwiftUI

enum LengthUnit: String, CaseIterable, Identifiable {
    case kilometers
    case miles

    var id: String { self.rawValue }

    var localizedKey: String.LocalizationValue {
        switch self {
        case .kilometers: return "length_unit_kilometers"
        case .miles: return "length_unit_miles"
        }
    }

    /// To use directly on SwiftUI views (as Text...)
    var localizedLabel: LocalizedStringKey {
        LocalizedStringKey(String(localized: localizedKey))
    }
}
