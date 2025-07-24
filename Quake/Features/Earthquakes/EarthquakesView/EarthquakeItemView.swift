//
//  EarthquakeItemView.swift
//  Quake
//
//  Created by Laura Zafra Prat on 9/2/24.
//

import SwiftUI

struct EarthquakeItemView: View {
    let getMagnitudeColorUseCase = GetMagnitudeColorUseCase()
    let earthquake: Earthquake
    @State var isExpanded: Bool
    @State private var navigate = false
    
    var body: some View {
        DisclosureGroup(
            isExpanded: $isExpanded,
            content: {
                VStack(alignment: .leading, spacing: Constants.Design.Dimens.semiLargeMargin) {
                    // DROPDOWN EARTHQUAKE DETAILS
                    ForEach([
                        ("earthquake_place", earthquake.place),
                        ("earthquake_date", earthquake.date),
                        ("earthquake_tsunami", earthquake.tsunami),
                        ("earthquake_coords", earthquake.formattedCoords),
                        ("earthquake_depth", earthquake.depth)
                    ], id: \.0) { key, value in
                        HStack(alignment: .top) {
                            Text(LocalizedStringKey(key))
                                .fontWeight(.bold)
                                .foregroundStyle(.gray)
                            + Text(":")
                                .fontWeight(.bold)
                                .foregroundStyle(.gray)
                            
                            Text(value)
                        }
                    }
                    
                    // SEE DETAIL BUTTON
                    HStack {
                        Spacer()
                        Button(action: {
                            navigate = true
                        }) {
                            Text("settings_see_details")
                                .foregroundColor(.teal)
                                .fontWeight(.semibold)
                                .underline(false)
                        }
                        .buttonStyle(.plain)
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Invisible NavigationLink
                    //TODO: Cambiar por no deprecated?
                    NavigationLink(destination: EarthquakeDetailView(earthquake: earthquake), isActive: $navigate) {
                        EmptyView()
                    }
                    .hidden()
                }
                .padding(.top, Constants.Design.Dimens.extraLargeMargin)
                .padding(. horizontal, Constants.Design.Dimens.semiLargeMargin)
                .background(Color.teal.opacity(Constants.Design.Dimens.detailsCardOpacity))
                .cornerRadius(Constants.Design.Dimens.cardCornerRadius)
            },
            label: {
                // EARTHQUAKE MAGNITUDE AND TITLE
                HStack (alignment: VerticalAlignment.center, spacing: Constants.Design.Dimens.mediumMargin) {
                    Text(earthquake.formattedMagnitude)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color(getMagnitudeColorUseCase.getMagnitudeColor(magnitude: earthquake.originalMagnitude)))
                    
                    Text(earthquake.simplifiedTitle)
                        .font(.title3)
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(Constants.Design.Dimens.extraSmallMargin)
                .multilineTextAlignment(.leading)
            }
        )
        .accentColor(.gray)
    }
}

#Preview {
    EarthquakeItemView(earthquake: .example, isExpanded: false)
}
