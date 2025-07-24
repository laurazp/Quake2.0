//
//  FAQView.swift
//  Quake
//
//  Created by Laura Zafra Prat on 12/5/25.
//

import SwiftUI

struct FAQView: View {
    var body: some View {
        VStack {
            // TITLE
            Text("settings_faq")
                .font(.title)
                .bold()
                .padding()
            
            ScrollView {
                VStack(spacing: 16) {
                    // FAQ LIST
                    ForEach(FAQData.faqItems) { item in
                        VStack(alignment: .leading, spacing: 12) {
                            Text(item.question)
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text(item.answer)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.invertedBackground)
                        .cornerRadius(12)
                        .shadow(color: Color.primary.opacity(0.15), radius: 4, x: 0, y: 2)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.invertedBackground.ignoresSafeArea())
        }
    }
}

#Preview {
    FAQView()
}
