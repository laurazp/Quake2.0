//
//  MessageType.swift
//  Quake
//
//  Created by Laura Zafra Prat on 15/5/25.
//

import Foundation

enum MessageType: String, CaseIterable, Identifiable {
    case request = "Request"
    case bugReport = "Bug Report"
    case question = "Question"
    case other = "Other"
    
    var id: String { self.rawValue }
}
