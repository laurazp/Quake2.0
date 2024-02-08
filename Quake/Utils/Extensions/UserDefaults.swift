//
//  UserDefaults.swift
//  Quake
//
//  Created by Laura Zafra Prat on 8/2/24.
//

import Foundation

extension UserDefaults {
    
    func saveUnits(unit: String) {
        UserDefaults.standard.set(unit, forKey: "Units")
    }
    
    func retrieveUnits() -> String {
        if (UserDefaults.standard.object(forKey: "Units") as? String != nil) {
            return UserDefaults.standard.object(forKey: "Units") as! String
        } else {
            return "kilometers"
        }
    }
}

