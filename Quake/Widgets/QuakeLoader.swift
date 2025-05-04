//
//  QuakeLoader.swift
//  Quake
//
//  Created by Laura Zafra Prat on 27/4/25.
//

import SwiftUI

struct QuakeLoader: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                .frame(width: 60, height: 60)
            
            Circle()
                .trim(from: 0, to: 1)
                .stroke(
                    AngularGradient(gradient: Gradient(colors: [Color.black, Color.teal]), center: .center),
                    style: StrokeStyle(lineWidth: 8, lineCap: .round)
                )
                .frame(width: 60, height: 60)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .animation(
                    Animation.linear(duration: 1.0)
                        .repeatForever(autoreverses: false),
                    value: isAnimating
                )
        }
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    QuakeLoader()
        .preferredColorScheme(.dark)
}
