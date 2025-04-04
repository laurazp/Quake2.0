//
//  GetDateFormatter.swift
//  Quake
//
//  Created by Laura Zafra Prat on 8/2/24.
//

import Foundation

class GetDateFormatter {
    
    let dateFormatter = DateFormatter()
    
    func formatDate(dateToFormat: Date) -> String {
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .long
        let formattedDate = dateFormatter.string(from: dateToFormat)
        
        return formattedDate
    }
    
    func formatDate(dateToFormat: Int64) -> String {
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .long
        let dateToFormat = Date(timeIntervalSince1970: Double(dateToFormat)/1000)
        let formattedDate = dateFormatter.string(from: dateToFormat)
        
        return formattedDate
    }
    
    func formatIntToDate(dateToFormat: Int64) -> Date {
        let formattedDate = Date(timeIntervalSince1970: Double(dateToFormat)/1000)
        return formattedDate
    }
    
    func simpleFormatDate(dateToFormat: Date) -> String {
        dateFormatter.dateStyle = .short
        let formattedDate = dateFormatter.string(from: dateToFormat)
        
        return formattedDate
    }
}
