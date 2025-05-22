//
//  AppInfoView.swift
//  Quake
//
//  Created by Laura Zafra Prat on 12/5/25.
//

import SwiftUI

struct AppInfoView: View {
    var body: some View {
        VStack {
            // TITLE
            Text("settings_app_info")
                .font(.title)
                .bold()
                .padding()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("app_info_general_title")
                        .font(.headline)
                        .foregroundColor(.primary)
                    CustomLink(text: "Data source credits belongs to USGS (United States Geological Survey)", linkText: "USGS (United States Geological Survey)", linkUrl: "https://www.usgs.gov/programs/earthquake-hazards")
                    
                    Color.clear
                        .frame(height: 8)
                    
                    Divider()
                    
                    Color.clear
                        .frame(height: 8)
                    
                    Text("app_info_credits_title")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    CustomLink(text: "Seismic icons created by Freepik - Flaticon", linkText: "Freepik - Flaticon", linkUrl: "https://www.flaticon.com/free-icons/seismic")
                    
                    CustomLink(text: "Earthquake icons created by fjstudio - Flaticon", linkText: "fjstudio - Flaticon", linkUrl: "https://www.flaticon.com/free-icons/earthquake")
                    
                    CustomLink(text: "Feedback form based on original CTFeedbackSwift Package from rizumita - Github", linkText: "rizumita - Github", linkUrl: "https://github.com/rizumita/CTFeedbackSwift")
                }
                .padding()
            }
        }
    }
}

#Preview {
    AppInfoView()
}
