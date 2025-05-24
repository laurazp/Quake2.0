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
    
    @State private var isSearchBarShown = false
    @State private var isDatePickerSheetPresented = false
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
                        VStack(alignment: .leading) {
                            // FILTERS VSTACK
                            VStack(alignment: .leading, spacing: 24) {
                                // FILTER AND SORT ROW
                                HStack {
                                    // FILTER BUTTON
                                    Button(action: {
                                        isSearchBarShown = !isSearchBarShown
                                    }) {
                                        HStack(spacing: 12) {
                                            Text("earthquakes_filter")
                                            Image(systemName: Constants.Images.filterEarthquakesIcon)
                                        }
                                        .foregroundStyle(Color(.gray))
                                    }
                                    .padding()
                                    .frame(height: 36, alignment: .center)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(16)
                                    
                                    // SORT BUTTON
                                    Button(action: {
                                        //TODO: Show sort options
                                    }) {
                                        HStack(spacing: 12) {
                                            Text("earthquakes_sort")
                                            Image(systemName: Constants.Images.sortEarthquakesIcon)
                                        }
                                        .foregroundStyle(Color(.gray))
                                    }
                                    .padding()
                                    .frame(height: 36, alignment: .center)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(16)
                                }
                                .padding([.horizontal, .top])
                                .frame(alignment: .center)
                                
                                HStack {
                                    // SEARCH BAR WITH DATE PICKER
                                    if isSearchBarShown {
                                        Button(action: {
                                            isDatePickerSheetPresented = true
                                        }) {
                                            HStack {
                                                Image(systemName: Constants.Images.searchDatesIcon)
                                                Text("earthquakes_search_date_range")
                                                    .foregroundColor(.gray)
                                                Spacer()
                                            }
                                            .padding()
                                            .background(Color(.systemGray6))
                                            .cornerRadius(16)
                                        }
                                        .padding()
                                        .frame(height: 28)
                                        .foregroundStyle(Color(.gray))
                                    }
                                }
                                
                                // CLEAR FILTERS BUTTON
                                if viewModel.isFiltering {
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            Task {
                                                viewModel.isFiltering = false
                                                viewModel.pageNumber = 0
                                                viewModel.filteredEarthquakes = []
                                                await viewModel.getLatestEarthquakes()
                                            }
                                        }) {
                                            HStack {
                                                Image(systemName: Constants.Images.clearFiltersIcon)
                                                    .foregroundColor(.red)
                                                Text("filters_clear_filters")
                                                    .font(.subheadline)
                                                    .foregroundStyle(Color(.gray))
                                            }
                                        }
                                        .padding()
                                        .frame(height: 36, alignment: .center)
                                        .background(Color(.systemGray6))
                                        .cornerRadius(16)
                                    }
                                    .padding(.horizontal)
                                    .frame(alignment: .center)
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
                            }
                            .navigationTitle("earthquakes_title")
                            .listStyle(.plain)
                            
                        }
                        .sheet(isPresented: $isDatePickerSheetPresented) {
                            DatePickerSheet(
                                startDate: $startDate,
                                endDate: $endDate,
                                isPresented: $isDatePickerSheetPresented,
                                onApply: {
                                    Task {
                                        await viewModel.filterEarthquakesByDate(selectedDates: [startDate, endDate])
                                        isDatePickerSheetPresented = false
                                        isSearchBarShown = false
                                        //TODO: Is it better to show dates instead of hidding the search bar?
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
