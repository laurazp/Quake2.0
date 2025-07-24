//
//  FAQItem.swift
//  Quake
//
//  Created by Laura Zafra Prat on 17/5/25.
//

import Foundation

struct FAQItem: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}

struct FAQData {
    static let faqItems: [FAQItem] = [
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
}
