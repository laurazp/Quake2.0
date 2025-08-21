//
//  EarthquakesViewModel.swift
//  Quake
//
//  Created by Laura Zafra Prat on 9/2/24.
//

import Foundation

class EarthquakesViewModel: ObservableObject {
    @Published var earthquakes = [Earthquake]()
    @Published var filteredEarthquakes = [Earthquake]()
    @Published var isFiltering: Bool = false
    @Published var isSorted: Bool = false
    @Published var isLoading: Bool = false
    @Published var isLoadingPage: Bool = false
    @Published var hasMoreData: Bool = true
    @Published var inIncreasingOrder: Bool = false
    @Published var inAlphabeticalOrder: Bool = false
    @Published var inAscendingDateOrder: Bool = false
    @Published var pageNumber = 0
    @Published var searchText: String = ""
    @Published var error: Error?
    
    private let getEarthquakesUseCase: GetEarthquakesUseCase
    private let featureToEarthquakeMapper: FeatureToEarthquakeMapper
    private let pageSize = 20
    
    private(set) var lastStartDate: Date = Date()
    private(set) var lastEndDate: Date = Date()
    private(set) var placeQuery: String = ""
    
    init(getEarthquakesUseCase: GetEarthquakesUseCase,
         featureToEarthquakeMapper: FeatureToEarthquakeMapper) {
        self.getEarthquakesUseCase = getEarthquakesUseCase
        self.featureToEarthquakeMapper = featureToEarthquakeMapper
    }
    
    // MARK: - Paginated Earthquakes
    
    @MainActor
    func getLatestEarthquakes(isPaginating: Bool = false) async {
        guard !isLoading && !isLoadingPage && hasMoreData else { return }
        
        if isPaginating {
            isLoadingPage = true
        } else {
            isLoading = true
        }
        
        do {
            let offset = pageNumber * pageSize + 1
            let newQuakes = try await getEarthquakesUseCase.getLatestEarthquakes(offset: offset, pageSize: pageSize)
            
            DispatchQueue.main.async {
                if isPaginating {
                    self.earthquakes.append(contentsOf: newQuakes)
                } else {
                    self.earthquakes = newQuakes
                }
                
                self.hasMoreData = newQuakes.count == self.pageSize
                if self.hasMoreData {
                    self.pageNumber += 1
                }
                
                self.isLoading = false
                self.isLoadingPage = false
            }
        } catch {
            DispatchQueue.main.async {
                self.error = error
                self.isLoading = false
                self.isLoadingPage = false
            }
        }
    }
    
    // MARK: - Filtering
    
    @MainActor
    func filterEarthquakes(selectedDates: [Date], placeQuery: String) async {
        isFiltering = true
        pageNumber = 0
        filteredEarthquakes = [] // Clean list before adding new data
        hasMoreData = true
        
        lastStartDate = selectedDates[0]
        lastEndDate = selectedDates.count > 1 ? selectedDates[1] : selectedDates[0]
        self.placeQuery = placeQuery
        
        await getFilteredEarthquakes(selectedDates: [lastStartDate, lastEndDate], placeQuery: placeQuery)
    }
    
    @MainActor
    private func getFilteredEarthquakes(selectedDates: [Date], placeQuery: String) async {
        guard selectedDates.count >= 1 else { return }
        
        let leftDate = selectedDates[0]
        let rightDate = selectedDates.count > 1 ? selectedDates[1] : nil
        let offset = pageNumber * pageSize + 1
        
        do {
            let earthquakes = try await getEarthquakesUseCase.getEarthquakesBetweenDates(
                leftDate,
                rightDate,
                offset: offset,
                pageSize: pageSize
            )
            
            hasMoreData = earthquakes.count == pageSize
            
            // Apply place query filter (if exists) over the new earthquakes
            var earthquakesToAppend = earthquakes
            if !placeQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                earthquakesToAppend = earthquakes.filter { eq in
                    eq.place.localizedCaseInsensitiveContains(placeQuery)
                }
            }
            
            if pageNumber == 0 {
                filteredEarthquakes = earthquakesToAppend
            } else {
                filteredEarthquakes.append(contentsOf: earthquakesToAppend)
            }
        } catch {
            self.error = error
        }
    }
    
    @MainActor
    func loadMoreFilteredEarthquakes() async {
        guard isFiltering, hasMoreData else { return }
        pageNumber += 1
        await getFilteredEarthquakes(selectedDates: [lastStartDate, lastEndDate], placeQuery: placeQuery)
    }
    
    @MainActor
    func clearFiltersAndReload() async {
        isFiltering = false
        isSorted = false
        pageNumber = 0
        hasMoreData = true
        placeQuery = ""
        filteredEarthquakes = []
        await getLatestEarthquakes(isPaginating: false)
    }
    
    // MARK: - Ordering
    
    func orderFeaturesByMagnitude() {
        inIncreasingOrder = !inIncreasingOrder
        if (isFiltering) {
            filteredEarthquakes.sort(by: { inIncreasingOrder ? $0.formattedMagnitude < $1.formattedMagnitude : $0.formattedMagnitude > $1.formattedMagnitude })
        } else {
            earthquakes.sort(by: { inIncreasingOrder ? $0.formattedMagnitude < $1.formattedMagnitude : $0.formattedMagnitude > $1.formattedMagnitude })
        }
        isSorted = true
    }
    
    func orderFeaturesByPlace() {
        if !inAlphabeticalOrder {
            if isFiltering {
                filteredEarthquakes.sort(by: { $0.simplifiedTitle.lowercased().folding(options: .diacriticInsensitive, locale: Locale.current) < $1.simplifiedTitle.lowercased().folding(options: .diacriticInsensitive, locale: Locale.current) })
                inAlphabeticalOrder = true
            } else {
                earthquakes.sort(by: { $0.simplifiedTitle.lowercased().folding(options: .diacriticInsensitive, locale: Locale.current) < $1.simplifiedTitle.lowercased().folding(options: .diacriticInsensitive, locale: Locale.current) })
                inAlphabeticalOrder = true
            }
        } else {
            if isFiltering {
                filteredEarthquakes.sort(by: { $0.simplifiedTitle.lowercased().folding(options: .diacriticInsensitive, locale: Locale.current) > $1.simplifiedTitle.lowercased().folding(options: .diacriticInsensitive, locale: Locale.current) })
                inAlphabeticalOrder = false
            } else {
                earthquakes.sort(by: { $0.simplifiedTitle.lowercased().folding(options: .diacriticInsensitive, locale: Locale.current) > $1.simplifiedTitle.lowercased().folding(options: .diacriticInsensitive, locale: Locale.current) })
                inAlphabeticalOrder = false
            }
        }
        isSorted = true
    }
    
    func orderFeaturesByDate() {
        if (!inAscendingDateOrder) {
            if (isFiltering) {
                filteredEarthquakes.sort(by: { $0.originalDate < $1.originalDate })
                inAscendingDateOrder = true
            } else {
                earthquakes.sort(by: { $0.originalDate < $1.originalDate })
                inAscendingDateOrder = true
            }
        } else {
            if (isFiltering) {
                filteredEarthquakes.sort(by: { $1.originalDate < $0.originalDate })
                inAscendingDateOrder = false
            } else {
                earthquakes.sort(by: { $1.originalDate < $0.originalDate })
                inAscendingDateOrder = false
            }
        }
        isSorted = true
    }
}
