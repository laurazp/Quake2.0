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
    @State private var showSortButtons = false
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var searchText = ""
    
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
                                    Spacer()
                                    // FILTER BUTTON
                                    CustomButton(
                                        buttonText: String(localized: "earthquakes_filter"),
                                        buttonImage: Constants.Images.filterEarthquakesIcon,
                                        isFontSmall: false,
                                        action: {
                                            isDatePickerSheetPresented = true
//                                        isSearchBarShown = !isSearchBarShown
                                    })
                                    
                                    // SORT BUTTON
                                    CustomButton(
                                        buttonText: String(localized: "earthquakes_sort"),
                                        buttonImage: Constants.Images.sortEarthquakesIcon,
                                        isFontSmall: false,
                                        action: {
                                        //TODO: Show sort options
                                        showSortButtons = !showSortButtons
                                    })
                                }
                                .padding([.horizontal, .top])
                                
                                // SORT BUTTONS ROW
                                if showSortButtons {
                                    HStack {
                                        CustomButton(
                                            buttonText: String(localized: "earthquakes_sort_by_magnitude"),
                                            buttonImage: viewModel.inIncreasingOrder ? Constants.Images.arrowDownIcon : Constants.Images.arrowUpIcon,
                                            isFontSmall: true,
                                            action: {
                                            viewModel.orderFeaturesByMagnitude()
                                            //TODO: Show Clear filters button
                                        })
                                        CustomButton(
                                            buttonText: String(localized: "earthquakes_sort_by_place"),
                                            buttonImage: viewModel.inAlphabeticalOrder ? Constants.Images.arrowDownIcon : Constants.Images.arrowUpIcon,
                                            isFontSmall: true,
                                            action: {
                                            viewModel.orderFeaturesByPlace()
                                        })
                                        CustomButton(
                                            buttonText: String(localized: "earthquakes_sort_by_date"),
                                            buttonImage: viewModel.inAscendingDateOrder ? Constants.Images.arrowDownIcon : Constants.Images.arrowUpIcon,
                                            isFontSmall: true,
                                            action: {
                                            viewModel.orderFeaturesByDate()
                                        })
                                    }
                                    .padding(.horizontal)
                                }
                                
                                // CLEAR FILTERS BUTTON
                                if viewModel.isFiltering {
                                    HStack {
                                        Spacer()
                                    CustomButton(
                                        buttonText: String(localized: "filters_clear_filters"),
                                        buttonImage: Constants.Images.clearFiltersIcon,
                                        isFontSmall: true,
                                        action: {
                                            Task {
                                                viewModel.isFiltering = false
                                                viewModel.pageNumber = 0
                                                viewModel.filteredEarthquakes = []
                                                await viewModel.getLatestEarthquakes()
                                            }
                                        }
                                    )
                                    }
                                }
                                
//                                HStack {
//                                    // SEARCH BAR WITH DATE PICKER
//                                    if isSearchBarShown {
//                                        Button(action: {
//                                            isDatePickerSheetPresented = true
//                                        }) {
//                                            HStack {
//                                                Image(systemName: Constants.Images.searchDatesIcon)
//                                                Text("earthquakes_search_date_range")
//                                                    .foregroundColor(.gray)
//                                                Spacer()
//                                            }
//                                            .padding()
//                                            .background(Color(.systemGray6))
//                                            .cornerRadius(16)
//                                        }
//                                        .padding()
//                                        .frame(height: 40)
//                                        .foregroundStyle(Color(.gray))
//                                    }
//                                }
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
                                                    await viewModel.getLatestEarthquakes(isPaginating: true)
                                                }
                                            }
                                        }
                                    }
                            }
                            .navigationTitle("earthquakes_title")
                            .listStyle(.plain)
                            
                        }
                        .sheet(isPresented: $isDatePickerSheetPresented) {
                            // DATE PICKER SHEET
                            FiltersSheet(
                                startDate: $startDate,
                                endDate: $endDate,
                                searchText: $searchText,
                                isPresented: $isDatePickerSheetPresented,
                                onApply: {
                                    Task {
                                        await viewModel.filterEarthquakesByDate(selectedDates: [startDate, endDate])
                                        //TODO: viewModel.filterEarthquakesByPlace(searchText: searchText)
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
                                    .background(.teal)
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
