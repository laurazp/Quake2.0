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
