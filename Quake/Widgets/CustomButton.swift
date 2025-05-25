//
//  CustomButton.swift
//  Quake
//
//  Created by Laura Zafra Prat on 25/5/25.
//

import SwiftUI

struct CustomButton: View {
    let buttonText: String
    let buttonImage: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack(spacing: Constants.Design.Dimens.mediumMargin) {
                Text(buttonText)
                Image(systemName: buttonImage)
            }
            .foregroundStyle(Color(.gray))
        }
        .padding()
        .frame(height: Constants.Design.Dimens.customButtonheight, alignment: .center)
        .background(Color(.systemGray6))
        .cornerRadius(Constants.Design.Dimens.semiLargeMargin)
    }
}

#Preview {
    CustomButton(buttonText: "Sort", buttonImage: Constants.Images.sortEarthquakesIcon, action: {})
}
