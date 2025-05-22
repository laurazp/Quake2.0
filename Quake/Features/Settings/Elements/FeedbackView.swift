//
//  FeedbackView.swift
//  Quake
//
//  Created by Laura Zafra Prat on 15/5/25.
//

import SwiftUI
import MessageUI

struct FeedbackView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var didTapSend = false
    
    /// Message variables
    @State private var selectedType: MessageType = .request
    @State private var messageText: String = ""
    
    /// Image picker variables
    @State private var showPhotoOptions = false
    @State private var showImagePicker = false
    @State private var imagePickerSource: ImagePicker.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var showMailView = false
    
    var body: some View {
        VStack(spacing: Constants.Design.Dimens.zero) {
            // TITLE
            Text("feedback_send_feedback")
                .font(.title)
                .bold()
                .padding()
            
            ScrollView {
                VStack {
                    // TOPIC
                    FeedbackCard {
                        HStack {
                            createFeedbackRow(title: String(localized: LocalizedStringResource("feedback_topic")), text: "")
                            Menu {
                                ForEach(MessageType.allCases) { type in
                                    Button(action: {
                                        selectedType = type
                                    }) {
                                        Text(type.localizedLabel)
                                    }
                                }
                            } label: {
                                HStack {
                                    Text(selectedType.localizedLabel)
                                        .foregroundColor(.black.opacity(0.6))
                                    Image(systemName: Constants.Images.chevronDownIcon)
                                        .foregroundColor(.black.opacity(0.5))
                                        .font(.system(size: 14, weight: .semibold))
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 6)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(Constants.Design.Dimens.cardCornerRadius)
                            }
                        }
                        Divider()
                        
                        TextField("feedback_textfield_hint", text: $messageText)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding(Constants.Design.Dimens.smallMargin)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(Constants.Design.Dimens.cardCornerRadius)
                    }
                    
                    // ADDITIONAL INFO
                    //TODO: Open camera or gallery
                    FeedbackCard {
                        HStack {
                            createFeedbackRow(title: String(localized: LocalizedStringResource("feedback_select_attachment")), text: "")
                            Image(systemName: Constants.Images.chevronRightIcon)
                                .foregroundColor(.black.opacity(0.5))
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .onTapGesture {
                            showPhotoOptions = true
                        }
                        .confirmationDialog("feedback_choose_option", isPresented: $showPhotoOptions, titleVisibility: .visible) {
                            Button("feedback_open_camera") {
                                imagePickerSource = .camera
                                showImagePicker = true
                            }
                            Button("feedback_open_gallery") {
                                imagePickerSource = .photoLibrary
                                showImagePicker = true
                            }
                            Button("btn_cancel", role: .cancel) {
                            }
                        }
                        .sheet(isPresented: $showImagePicker) {
                            ImagePicker(sourceType: imagePickerSource) { image in
                                selectedImage = image
                                //TODO: Use image here?
                            }
                        }
                    }
                    
                    // DEVICE INFO
                    FeedbackCard {
                        createFeedbackRow(title: String(localized: LocalizedStringResource("device_operating_system_ios")), text: UIDevice.current.systemVersion) // Device system version
                    }
                    
                    // APP INFO
                    FeedbackCard {
                        createFeedbackRow(title: String(localized: LocalizedStringResource("feedback_name")), text: String(localized: LocalizedStringResource("quake_app_name")))
                        createFeedbackRow(title: String(localized: LocalizedStringResource("feedback_version")), text: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "N/A") // App version
                        createFeedbackRow(title: String(localized: LocalizedStringResource("feedback_build")), text: Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "N/A") // App build
                    }
                    
                    Button(action: {
                        didTapSend = true
                        //TODO: Send mail with all info
                        showMailView = true
                    }) {
                        Text("feedback_send_feedback")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                    }
                    .sheet(isPresented: $showMailView) {
                        if MFMailComposeViewController.canSendMail() {
                            if let image = selectedImage,
                               let imageData = image.jpegData(compressionQuality: 0.8) {
                                
                                MailView(
                                    subject: selectedType.rawValue,
                                    body: messageText,
                                    toRecipients: ["luridevlabs@gmail.com"],
                                    attachment: imageData,
                                    mimeType: "image/jpeg",
                                    fileName: "screenshot.jpg"
                                )
                            } else {
                                Text("feedback_image_error")
                                    .padding()
                            }
                        } else {
                            Text("feedback_mail_error")
                                .padding()
                        }
                    }
                }
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
