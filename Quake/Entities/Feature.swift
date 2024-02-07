//
//  Feature.swift
//  Quake
//
//  Created by Laura Zafra Prat on 7/2/24.
//

import Foundation

struct Feature: Decodable {
    let properties: Property
    let geometry: Geometry
    
    static var example: Feature {
        Feature(
            properties: Property(
                mag: 4.5,
                place: "California",
                time: 129834567,
                tsunami: 0,
                title: "California Rift Valley"),
            geometry: Geometry(
                coordinates: [45.0, 78.2]))
    }
}

struct Property: Decodable {
    let mag: Double?
    let place: String?
    let time: Int64?
    let tsunami: Int?
    let title: String?
}

struct Geometry: Decodable {
    let coordinates: [Float]
}
