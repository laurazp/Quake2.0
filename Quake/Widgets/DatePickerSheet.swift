//
//  DatePickerSheet.swift
//  Quake
//
//  Created by Laura Zafra Prat on 22/5/25.
//

import SwiftUI

struct DatePickerSheet: View {
    @Binding var startDate: Date
    @Binding var endDate: Date
    @Binding var isPresented: Bool
    let onApply: () -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                DatePicker("date_picker_start_day", selection: $startDate, displayedComponents: .date)
                DatePicker("date_picker_end_date", selection: $endDate, in: startDate..., displayedComponents: .date)
            }
            .navigationTitle("date_picker_select_range")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("btn_apply") {
                        onApply()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("btn_cancel") {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
    @Previewable @State var isPresented: Bool = false
    
    DatePickerSheet(startDate: $startDate, endDate: $endDate, isPresented: $isPresented, onApply: {})
}
