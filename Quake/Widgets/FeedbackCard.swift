//
//  FeedbackCard.swift
//  Quake
//
//  Created by Laura Zafra Prat on 15/5/25.
//

import SwiftUI

struct FeedbackCard<Content: View>: View {
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        VStack(spacing: Constants.Design.Dimens.mediumMargin) {
            content()
        }
        .cardStyle()
    }
}
