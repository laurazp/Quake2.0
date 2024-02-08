//
//  APIResponse.swift
//  Quake
//
//  Created by Laura Zafra Prat on 7/2/24.
//

import Foundation

struct APIResponse: Decodable {
    let features: [Feature]
}
