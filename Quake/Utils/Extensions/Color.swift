//
//  Color.swift
//  Quake
//
//  Created by Laura Zafra Prat on 24/7/25.
//

import SwiftUI

extension Color {
    static var invertedBackground: Color {
        Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .black : .white
        })
    }
}
