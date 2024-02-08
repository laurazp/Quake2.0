//
//  NetworkClient.swift
//  Quake
//
//  Created by Laura Zafra Prat on 7/2/24.
//


protocol NetworkClient {
    
    func get(url: String) async throws -> APIResponse
}
