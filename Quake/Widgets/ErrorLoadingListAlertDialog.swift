//
//  ErrorLoadingListAlertDialog.swift
//  Quake
//
//  Created by Laura Zafra Prat on 9/2/24.
//

import SwiftUI

struct ErrorLoadingListAlertDialog: ViewModifier {
    
    private struct Layout {
        static let errorAlertTitle = "Error loading list"
        static let cancelButtonTitle = "OK"
        static let retryButtonTitle = "Retry"
    }
    
    let error: Error?
    let errorMessage: String?
    var retryButtonAction: () -> Void
    
    func body(content: Content) -> some View {
        content
            .alert(Layout.errorAlertTitle, isPresented: Binding.constant(error != nil)) {
                Button(Layout.cancelButtonTitle) {}
                Button(Layout.retryButtonTitle) {
                    Task {
                        retryButtonAction()
                    }
                }
            } message: {
                Text(errorMessage ?? "")
            }
    }
}

extension View {
    func errorLoadingListAlertDialog(error: Error?, errorMessage: String?, retryButtonAction: @escaping () -> Void) -> some View {
        modifier(ErrorLoadingListAlertDialog(error: error, errorMessage: errorMessage, retryButtonAction: retryButtonAction))
    }
}
