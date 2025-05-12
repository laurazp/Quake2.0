//
//  SettingsView.swift
//  Quake
//
//  Created by Laura Zafra Prat on 11/2/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                // CONFIGURATION SECTION
                Section(header: Text("settings_configuration")) {
                    createRow(
                        for: "settings_units",
                        imageName: Constants.Images.unitsSettingsImageName,
                        imageColor: Constants.Design.Colors.Mint) {
                        UnitsView()
                    }
                    createRow(
                        for: "settings_location_services",
                        imageName: Constants.Images.locationSettingsImageName,
                        imageColor: Constants.Design.Colors.Orange) {
                        LocationServicesView()
                    }
                }
                
                // GENERAL SECTION
                Section(header: Text("settings_general")) {
                    createRow(
                        for: "settings_app_info",
                        imageName: Constants.Images.infoSettingsImageName,
                        imageColor: Constants.Design.Colors.Red) {
                        AppInfoView()
                    }
                    createRow(
                        for: "settings_faq",
                        imageName: Constants.Images.faqSettingsImageName,
                        imageColor: Constants.Design.Colors.Blue) {
                        FAQView()
                    }
                    createRow(
                        for: "settings_feedback",
                        imageName: Constants.Images.feedbackSettingsImageName,
                        imageColor: Constants.Design.Colors.Green) {
                        FeedbackView()
                    }
                }
            }
            .navigationTitle("settings_title")
            .listStyle(InsetGroupedListStyle())
        }
    }
    
    private func createRow<Destination: View>(
        for title: LocalizedStringKey,
        imageName: String,
        imageColor: UIColor,
        @ViewBuilder destination: @escaping () -> Destination
    ) -> some View {
        NavigationLink(destination: destination()) {
            HStack(spacing: Constants.Design.Dimens.mediumMargin) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: Constants.Design.Dimens.mediumMargin, height: Constants.Design.Dimens.mediumMargin)
                    .padding()
                    .background(Color(uiColor: imageColor).opacity(Constants.Design.Dimens.imageOpacity))
                    .clipShape(RoundedRectangle(cornerRadius: Constants.Design.Dimens.mediumMargin))
                Text(title)
            }
            .frame(height: Constants.Design.Dimens.settingsRowHeight)
        }
    }
}

#Preview {
    SettingsView()
}
