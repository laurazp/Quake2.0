//
//  CustomLink.swift
//  Quake
//
//  Created by Laura Zafra Prat on 22/5/25.
//

import SwiftUI

struct CustomLink: View {
    let text: String
    let linkText: String
    let linkUrl: String
    
    var body: some View {
        Text(makeAttributedText(text: text, linkText: linkText))
            .font(.body)
            .multilineTextAlignment(.leading)
    }
    
    private func makeAttributedText(text: String, linkText: String) -> AttributedString {
        var attributed = AttributedString(text)
        
        if let range1 = attributed.range(of: linkText) {
            attributed[range1].link = URL(string: linkUrl)
            attributed[range1].foregroundColor = .orange
            attributed[range1].underlineStyle = []
        }
        
        return attributed
    }
}

#Preview {
    CustomLink(text: "Seismic icons created by Freepik - Flaticon", linkText: "Freepik - Flaticon", linkUrl: "https://www.freepik.com")
}
