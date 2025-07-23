//
//  FAQView.swift
//  Quake
//
//  Created by Laura Zafra Prat on 12/5/25.
//

import SwiftUI

struct FAQView: View {
    
    //TODO: Remove from this view?
    let faqItems: [FAQItem] = [
        FAQItem(
            question: String(localized: "faq_question_1"),
            answer: String(localized: "faq_answer_1")
        ),
        FAQItem(
            question: String(localized: "faq_question_2"),
            answer: String(localized: "faq_answer_2")
        ),
        FAQItem(
            question: String(localized: "faq_question_3"),
            answer: String(localized: "faq_answer_3")
        ),
        FAQItem(
            question: String(localized: "faq_question_4"),
            answer: String(localized: "faq_answer_4")
        ),
        FAQItem(
            question: String(localized: "faq_question_5"),
            answer: String(localized: "faq_answer_5")
        ),
        FAQItem(
            question: String(localized: "faq_question_6"),
            answer: String(localized: "faq_answer_6")
        ),
        FAQItem(
            question: String(localized: "faq_question_7"),
            answer: String(localized: "faq_answer_7")
        )
    ]
    
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
                    ForEach(faqItems) { item in
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
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.white.ignoresSafeArea())
        }
    }
}

#Preview {
    FAQView()
}
