//
//  EarthquakesRemoteService.swift
//  Quake
//
//  Created by Laura Zafra Prat on 8/2/24.
//

import Foundation

struct EarthquakesRemoteService {
    
    let networkClient: URLSessionNetworkClient
    let featureToEarthquakeModelMapper = FeatureToEarthquakeModelMapper()
    
    //let offset = 1
    enum Constants {
        static let pageSize = 20
    }
    
    init(networkClient: URLSessionNetworkClient) {
        self.networkClient = networkClient
    }
    
    func getEarthquakes(startTime: String, endTime: String, offset: Int, pageSize: Int) async throws -> [EarthquakeModel] {
        
        let actualOffset = offset
        let selectedPageSize = getPageSize(pageSize: pageSize)
        
        let urlString = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=\(startTime)&endtime=\(endTime)&limit=\(selectedPageSize)&offset=\(actualOffset)"
        
        let response: APIResponse = try await networkClient.get(url: urlString)
        
        var earthquakes = [EarthquakeModel]()
        for feature in response.features {
            earthquakes.append(featureToEarthquakeModelMapper.map(from: feature))
        }
        
        return earthquakes
    }
    
    func getPageSize(pageSize: Int) -> Int {
        var finalPageSize = 0
        if pageSize != 20 {
            finalPageSize = pageSize
        } else {
            finalPageSize = Constants.pageSize
        }
        return finalPageSize
    }
}
