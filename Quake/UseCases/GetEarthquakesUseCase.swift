//
//  GetEarthquakesUseCase.swift
//  Quake
//
//  Created by Laura Zafra Prat on 7/2/24.
//

import Foundation

typealias GetEarthquakesResult = ([Feature]) -> ()
private let dateFormatterGet = DateFormatter()

struct GetEarthquakesUseCase {
    private let earthquakesRepository: EarthquakesRepository
    private let getTimeRangeUseCase = GetTimeRangeUseCase()
    
    func getLatestEarthquakes(days: Int = 30, offset: Int, pageSize: Int, completion: @escaping GetEarthquakesResult) async throws {
        let timeRange = getTimeRangeUseCase.getTimeRange(days: days)
        try await earthquakesRepository.getEarthquakes(startTime: timeRange.start,
                              endTime: timeRange.end,
                              offset: offset,
                              pageSize: pageSize/*,
                              completion: completion*/)
    }
    
    func getEarthquakesBetweenDates(_ startDate: Date, _ endDate: Date?, offset: Int, pageSize: Int, completion: @escaping GetEarthquakesResult) async throws {
        let dateRange = getTimeRangeUseCase.getDateRangeFromDates(startDate: startDate, endDate: endDate)
        try await earthquakesRepository.getEarthquakes(startTime: dateRange.start,
                              endTime: dateRange.end,
                              offset: offset,
                              pageSize: pageSize/*,
                              completion: completion*/)
    }
    
    //TODO: modificar completion???
    /*func execute() async throws -> [Feature] {
        try await earthquakesRepository.getEarthquakes()
    }*/
}
