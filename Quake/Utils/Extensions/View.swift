//
//  View.swift
//  Quake
//
//  Created by Laura Zafra Prat on 15/5/25.
//

import SwiftUI

extension View {
    func cardStyle(
        backgroundColor: Color = Color(UIColor.secondarySystemBackground),
        cornerRadius: CGFloat = 16,
        shadowColor: Color = Color.black.opacity(0.1),
        shadowRadius: CGFloat = 5,
        shadowOffsetX: CGFloat = 0,
        shadowOffsetY: CGFloat = 2
    ) -> some View {
        self
            .padding()
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
                    .shadow(color: shadowColor, radius: shadowRadius, x: shadowOffsetX, y: shadowOffsetY)
            )
            .padding()
    }
}
