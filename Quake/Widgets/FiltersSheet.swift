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
                    Text("filters_select_dates_range")
                        .font(.headline)
                    VStack(alignment: .leading, spacing: 10) {
                        DatePicker("filters_start_date", selection: $startDate, displayedComponents: .date)
                        DatePicker("filters_end_date", selection: $endDate, in: startDate..., displayedComponents: .date)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    
                    // PLACE SEARCH SECTION
                    Text("filters_search_place")
                        .font(.headline)
                    VStack(alignment: .leading, spacing: 10) {
                        TextField("filters_enter_place_name", text: $searchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(16)
                }
                .padding()
            }
            .navigationTitle("filters_sheet_title")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("btn_apply") {
                        onApply()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("btn_cancel") {
                        isPresented = false
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var startDate = Date()
    @Previewable @State var endDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    @Previewable @State var searchText = ""
    @Previewable @State var isPresented: Bool = false
    
    FiltersSheet(startDate: $startDate, endDate: $endDate, searchText: $searchText, isPresented: $isPresented, onApply: {})
}
