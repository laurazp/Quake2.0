//
//  MessageType.swift
//  Quake
//
//  Created by Laura Zafra Prat on 15/5/25.
//

import SwiftUI

enum MessageType: String, CaseIterable, Identifiable {
    case request
    case bugReport
    case question
    case other
    
    var id: String { self.rawValue }
    
    var localizedLabel: LocalizedStringKey {
        switch self {
        case .request: return "message_type_request"
        case .bugReport: return "message_type_bug_report"
        case .question: return "message_type_question"
        case .other: return "message_type_other"
        }
    }
}
