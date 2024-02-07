//
//  URLSessionNetworkClient.swift
//  Quake
//
//  Created by Laura Zafra Prat on 7/2/24.
//

import Foundation

class URLSessionNetworkClient: NetworkClient {
    func get/*<Feature: Decodable>*/(url: String) async throws -> Feature {
        
        guard let url = URL(string: url) else {
            throw NetworkClientError.badUrl
        }
        
        let data = try await URLSession.shared.data(from: url).0
        
        return try JSONDecoder().decode(Feature.self, from: data)
    }
}
