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
    let isFontSmall: Bool?
    let isIconRed: Bool?
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack(spacing: Constants.Design.Dimens.mediumMargin) {
                Text(buttonText)
                if !buttonImage.isEmpty {
                    Image(systemName: buttonImage)
                }
            }
            .foregroundStyle(isIconRed ?? false ? Color(.red) : Color(.gray))
            .font(isFontSmall ?? false ? .footnote : .body)
        }
        .padding()
        .frame(height: Constants.Design.Dimens.customButtonheight, alignment: .center)
        .background(isIconRed ?? false ? Color(.systemGray6) : Color(.systemGray6))
        .cornerRadius(Constants.Design.Dimens.semiLargeMargin)
        .background(Color.white)
        .overlay(isIconRed ?? false ?
            RoundedRectangle(cornerRadius: Constants.Design.Dimens.semiLargeMargin)
            .stroke(Color.red, lineWidth: 1) : nil
        )
    }
}

#Preview {
    CustomButton(buttonText: "Sort", buttonImage: Constants.Images.sortEarthquakesIcon, isFontSmall: false, isIconRed: false, action: {})
}
