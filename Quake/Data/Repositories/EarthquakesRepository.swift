//
//  EarthquakesRepository.swift
//  Quake
//
//  Created by Laura Zafra Prat on 8/2/24.
//

import Foundation

struct EarthquakesRepository {
    private let remoteService: EarthquakesRemoteService
    
    init(remoteService: EarthquakesRemoteService) {
        self.remoteService = remoteService
    }
    
    func getEarthquakes(startTime: String, endTime: String, offset: Int, pageSize: Int) async throws -> [Earthquake] {
        
        do {
            return try await remoteService.getEarthquakes(startTime: startTime, endTime: endTime, offset: offset, pageSize: pageSize)
        } catch(let error) {
            print(error.localizedDescription)
            throw error
        }
    }
}
