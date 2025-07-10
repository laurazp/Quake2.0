//
//  FiltersSheet.swift
//  Quake
//
//  Created by Laura Zafra Prat on 22/5/25.
//

import SwiftUI

struct FiltersSheet: View {
    @Binding var startDate: Date
    @Binding var endDate: Date
    @Binding var searchText: String
    @Binding var isPresented: Bool
    let onApply: () -> Void
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // DATE SELECTION SECTION
                    Text("Select dates range")
                        .font(.headline)
                    VStack(alignment: .leading, spacing: 10) {
                        DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                        DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: .date)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    
                    // PLACE SEARCH SECTION
                    Text("Search place")
                        .font(.headline)
                    VStack(alignment: .leading, spacing: 10) {
                        TextField("Enter place name", text: $searchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(16)
                }
                .padding()
            }
            .navigationTitle("Filters")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Apply") {
                        onApply()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
            }
        }
        
        //        NavigationStack {
        //            VStack {
        //                Section(header: Text("Select dates range")) {
        //                    DatePicker("date_picker_start_day", selection: $startDate, displayedComponents: .date)
        //                    DatePicker("date_picker_end_date", selection: $endDate, in: startDate..., displayedComponents: .date)
        //                }
        //                .padding()
        //                .colorMultiply(.teal)
        //
        //                Section(header: Text("Search place")) {
        //                    Button(action: {
        //
        //                    }) {
        //                        HStack {
        //                            Image(systemName: Constants.Images.searchDatesIcon)
        //                            TextField("Enter place name", text: $searchText)
        //                                .textFieldStyle(RoundedBorderTextFieldStyle())
        ////                            Text("earthquakes_search_date_range")
        //                                .foregroundColor(.gray)
        //                        }
        //                        .padding()
        //                        .background(Color(.systemGray6))
        //                        .cornerRadius(16)
        //                    }
        //                    .padding()
        //                    .frame(height: 40)
        //                    .foregroundStyle(Color(.gray))
        ////                                    TextField("Enter place name", text: $searchText)
        ////                                        .textFieldStyle(RoundedBorderTextFieldStyle())
        //                }
        //            }
        //            .navigationTitle("Filters")
        //            .toolbar {
        //                ToolbarItem(placement: .confirmationAction) {
        //                    Button("btn_apply") {
        //                        onApply()
        //                    }
        //                }
        //                ToolbarItem(placement: .cancellationAction) {
        //                    Button("btn_cancel") {
        //                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        //                        isPresented = false
        //                    }
        //                }
        //            }
        //        }
        //    }
    }
}
    
    #Preview {
        @Previewable @State var startDate = Date()
        @Previewable @State var endDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        @Previewable @State var searchText = ""
        @Previewable @State var isPresented: Bool = false
        
        FiltersSheet(startDate: $startDate, endDate: $endDate, searchText: $searchText, isPresented: $isPresented, onApply: {})
    }
