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
    @ObservedObject var viewModel: SettingsViewModel
    @State private var didTapSend = false
    
    /// Image picker variables
    @State private var showPhotoOptions = false
    @State private var showImagePicker = false
    @State private var imagePickerSource: ImagePicker.SourceType = .photoLibrary
    
    @State private var showMailView = false
    
    init(viewModel: SettingsViewModel = SettingsViewModel()) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
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
                                        viewModel.selectedType = type
                                    }) {
                                        Text(type.localizedLabel)
                                    }
                                }
                            } label: {
                                HStack {
                                    Text(viewModel.selectedType.localizedLabel)
                                        .foregroundColor(.primary.opacity(0.6))
                                    Image(systemName: Constants.Images.chevronDownIcon)
                                        .foregroundColor(.primary.opacity(0.5))
                                        .font(.system(size: 14, weight: .semibold))
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 6)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(Constants.Design.Dimens.cardCornerRadius)
                            }
                        }
                        Divider()
                        
                        TextField("feedback_textfield_hint", text: $viewModel.messageText)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding(Constants.Design.Dimens.smallMargin)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(Constants.Design.Dimens.cardCornerRadius)
                    }
                    
                    // ADDITIONAL INFO
                    FeedbackCard {
                        HStack {
                            createFeedbackRow(title: String(localized: LocalizedStringResource("feedback_select_attachment")), text: "")
                            Spacer()
                            Image(systemName: Constants.Images.chevronRightIcon)
                                .foregroundColor(.black.opacity(0.5))
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .contentShape(Rectangle()) /// taps work in all visible area of the HStack
                        .frame(maxWidth: .infinity)
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
                                viewModel.selectedImage = image
                            }
                        }
                    }
                    
                    // DEVICE INFO
                    FeedbackCard {
                        createFeedbackRow(title: String(localized: LocalizedStringResource("device_model")), text: viewModel.deviceModel) // Device model
                        createFeedbackRow(title: String(localized: LocalizedStringResource("device_operating_system_ios")), text: viewModel.deviceSystemVersion) // Device system version
                    }
                    
                    // APP INFO
                    FeedbackCard {
                        createFeedbackRow(title: String(localized: LocalizedStringResource("feedback_name")), text: viewModel.appName)
                        createFeedbackRow(title: String(localized: LocalizedStringResource("feedback_version")), text: viewModel.appVersion) // App version
                        createFeedbackRow(title: String(localized: LocalizedStringResource("feedback_build")), text: viewModel.appBuild) // App build
                    }
                    
                    Button(action: {
                        didTapSend = true
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
                            if let image = viewModel.selectedImage,
                               let imageData = image.jpegData(compressionQuality: 0.8) {
                                
                                MailView(
                                    subject: viewModel.selectedType.rawValue,
                                    body: composeEmailBody(),
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
        .onAppear() {
            viewModel.loadAppInfo()
        }
    }
    
    private func createFeedbackRow(title: String, text: String?) -> some View {
        HStack {
            Text(title)
                .font(.title3)
                .foregroundColor(.primary)
            if text != nil {
                Spacer()
                Text(text!)
            }
        }
    }
    
    private func composeEmailBody() -> String {
        """
        \(viewModel.messageText)
        
        -----------------------
        
        App Name: \(viewModel.appName)
        App Version: \(viewModel.appVersion)
        App Build: \(viewModel.appBuild)
        Device: \(UIDevice.current.model)
        iOS Version: \(UIDevice.current.systemVersion)
        """
    }
}


#Preview {
    FeedbackView()
}
