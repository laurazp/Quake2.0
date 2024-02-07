//
//  NetworkClient.swift
//  Quake
//
//  Created by Laura Zafra Prat on 7/2/24.
//


protocol NetworkClient {
    
    func get/*<Feature: Decodable>*/(url: String) async throws -> Feature
}
