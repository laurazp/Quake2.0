//
//  EarthquakesView.swift
//  Quake
//
//  Created by Laura Zafra Prat on 9/2/24.
//

import SwiftUI

struct EarthquakesView: View {
    @StateObject private var viewModel: EarthquakesViewModel
    @EnvironmentObject var coordinator: Coordinator
    
    @State private var isDatePickerPresented = false
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    init(viewModel: EarthquakesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                QuakeLoader()
            } else {
                ScrollViewReader { scrollViewProxy in
                    ZStack(alignment: .bottomTrailing) {
                        VStack {
                            VStack {
                                HStack {
                                    // SEARCH BAR WITH DATE PICKER
                                    Button(action: {
                                        isDatePickerPresented = true
                                    }) {
                                        HStack {
                                            Image(systemName: Constants.Images.searchDatesIcon)
                                            Text("earthquakes_search_date_range")
                                                .foregroundColor(.gray)
                                            Spacer()
                                        }
                                        .padding()
                                        .background(Color(.systemGray6))
                                        .cornerRadius(12)
                                    }
                                    .padding()
                                    
                                    //TODO: Order earthquakes button
                                }
                                
                                // TODO: CLEAR FILTER BUTTON
                                    if viewModel.isFiltering {
                                        Text("Clear Filters")
                                            .font(.subheadline)
                                            .foregroundColor(.blue)
                                            .padding(8)
                                            .frame(maxWidth: .infinity)
                                            .background(Color(.systemGray5))
                                            .cornerRadius(10)
                                            .onTapGesture {
                                                Task {
                                                    viewModel.isFiltering = false
                                                    viewModel.pageNumber = 0
                                                    viewModel.filteredEarthquakes = []
                                                    await viewModel.getLatestEarthquakes()
                                                }
                                            }
                                        
                                    }
                            }
                            
                            // EARTHQUAKES LIST
                            List(viewModel.isFiltering ? viewModel.filteredEarthquakes : viewModel.earthquakes) { earthquake in
                                createRow(for: earthquake)
                                    .id(earthquake.id)
                                    .onAppear {
                                        if viewModel.isFiltering {
                                            if earthquake == viewModel.filteredEarthquakes.last, viewModel.hasMoreData {
                                                Task {
                                                    await viewModel.loadMoreFilteredEarthquakes()
                                                }
                                            }
                                        } else {
                                            if earthquake == viewModel.earthquakes.last, viewModel.hasMoreData {
                                                Task {
                                                    let lastId = earthquake.id
                                                    await viewModel.getLatestEarthquakes(isPaginating: true)
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                        withAnimation {
                                                            scrollViewProxy.scrollTo(lastId, anchor: .top)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                //                                    .onAppear {
                                //                                        // Solo paginar si **no se está filtrando**
                                //                                        if !viewModel.isFiltering,
                                //                                           earthquake == viewModel.earthquakes.last {
                                //                                            Task {
                                //                                                let lastId = earthquake.id
                                //                                                await viewModel.getLatestEarthquakes(isPaginating: true)
                                //
                                //                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                //                                                    withAnimation {
                                //                                                        scrollViewProxy.scrollTo(lastId, anchor: .top)
                                //                                                    }
                                //                                                }
                                //                                            }
                                //                                        }
                                //                                    }
                            }
                            .navigationTitle("earthquakes_title")
                            .listStyle(.plain)
                            
                        }
                        .sheet(isPresented: $isDatePickerPresented) {
                            DatePickerSheet(
                                startDate: $startDate,
                                endDate: $endDate,
                                isPresented: $isDatePickerPresented,
                                onApply: {
                                    Task {
                                        await viewModel.filterEarthquakesByDate(selectedDates: [startDate, endDate])
                                        isDatePickerPresented = false
                                    }
                                }
                            )
                        }
                        
                        // FLOATING BUTTON TO SCROLL TO TOP
                        if !viewModel.earthquakes.isEmpty {
                            Button(action: {
                                if let firstId = viewModel.earthquakes.first?.id {
                                    withAnimation {
                                        scrollViewProxy.scrollTo(firstId, anchor: .top)
                                    }
                                }
                            }) {
                                Image(systemName: Constants.Images.arrowUpIcon)
                                    .font(.system(size: Constants.Design.Dimens.largeMargin, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .clipShape(Circle())
                                    .shadow(radius: 4)
                            }
                            .padding()
                        }
                    }
                }
            }
        }
        .errorLoadingListAlertDialog(error: viewModel.error, errorMessage: viewModel.error?.localizedDescription, retryButtonAction: {
            Task {
                await viewModel.getLatestEarthquakes()
            }
        })
        .task {
            await viewModel.getLatestEarthquakes()
        }
    }
    
    private func createRow(for earthquake: Earthquake) -> some View {
        EarthquakeItemView(earthquake: earthquake, isExpanded: false)
    }
}


#Preview {
    let coordinator = Coordinator()
    return coordinator.makeEarthquakesView()
        .environmentObject(coordinator)
}
