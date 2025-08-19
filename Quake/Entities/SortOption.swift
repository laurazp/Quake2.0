//
//  SortOption.swift
//  Quake
//
//  Created by Laura Zafra Prat on 19/8/25.
//

enum SortOption: String {
    case magnitude
    case date
    case name
}

enum SortOrder {
    case ascending
    case descending
    
    mutating func toggle() {
        self = self == .ascending ? .descending : .ascending
    }
}
