//
//  LocationServicesView.swift
//  Quake
//
//  Created by Laura Zafra Prat on 12/5/25.
//

import SwiftUI

struct LocationServicesView: View {
    @StateObject private var permissionManager = LocationPermissionManager()
    
    var body: some View {
        VStack(spacing: 24) {
            // TITLE
            Text("settings_location_services")
                .font(.title)
                .bold()
                .padding()
            
            Color.clear
                .frame(height: 50)
            
            Image(systemName: Constants.Images.locationPermissionsIcon)
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.blue)
            
            if permissionManager.isAuthorized {
                Text("location_permission_granted")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
                
                Text("location_permission_thank_you")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            } else {
                Text("location_permission_title")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
                
                Text("location_permission_description")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                
                if permissionManager.isDenied {
                    Button("location_permission_open_settings") {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url)
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(12)
                    .padding(.horizontal)
                } else {
                    Button("location_permission_button") {
                        permissionManager.requestPermission()
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
            }
            
            Spacer()
        }
        .padding()
        .frame(alignment: .top)
    }
}

#Preview {
    LocationServicesView()
}
