//
//  FeedbackView.swift
//  Quake
//
//  Created by Laura Zafra Prat on 15/5/25.
//

import SwiftUI

struct FeedbackView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var didTapSend = false
    
    @State private var selectedType: MessageType = .request
    @State private var messageText: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Send Feedback")
                .font(.title)
                .bold()
                .padding()
            
            // TOPIC
            FeedbackCard {
                HStack {
                    createFeedbackRow(title: "Topic", text: "")
                    Menu {
                        ForEach(MessageType.allCases) { type in
                            Button(type.rawValue) {
                                selectedType = type
                            }
                        }
                    } label: {
                        HStack {
                            Text(selectedType.rawValue)
                                .foregroundColor(.black.opacity(0.6))
                            Image(systemName: "chevron.down")
                                .foregroundColor(.black.opacity(0.5))
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 6)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
                Divider()
                
                TextField("Write your message here...", text: $messageText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(8)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
            }
            
            // ADDITIONAL INFO
            //TODO: Open camera or gallery
            FeedbackCard {
                HStack {
                    createFeedbackRow(title: "Select attachment", text: "")
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black.opacity(0.5))
                        .font(.system(size: 14, weight: .semibold))
                }
            }
            
            // DEVICE INFO
            FeedbackCard {
                createFeedbackRow(title: "iOS", text: UIDevice.current.systemVersion) // Device system version
            }
            
            // APP INFO
            FeedbackCard {
                createFeedbackRow(title: "Name", text: "Quake")
                createFeedbackRow(title: "Version", text: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "N/A") // App version
                createFeedbackRow(title: "Build", text: Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "N/A") // App build
            }
            
            Button(action: {
                didTapSend = true
                //TODO: Send mail with all info
            }) {
                Text("Send Feedback")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func createFeedbackRow(title: String, text: String) -> some View {
        HStack {
            Text(title)
                .font(.title3)
                .foregroundColor(.primary)
            Spacer()
            Text(text)
        }
    }
}


#Preview {
    FeedbackView()
}
