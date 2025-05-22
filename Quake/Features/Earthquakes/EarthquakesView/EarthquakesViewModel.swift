//
//  EarthquakesViewModel.swift
//  Quake
//
//  Created by Laura Zafra Prat on 9/2/24.
//

import Foundation

class EarthquakesViewModel: ObservableObject {
    @Published var earthquakes = [Earthquake]()
    @Published var isFiltering = false
    @Published var isLoading = false
    @Published var isLoadingPage = false
    @Published var hasMoreData = true
    @Published var pageNumber = 0
    @Published var error: Error?
    
    private let getEarthquakesUseCase: GetEarthquakesUseCase
    private let featureToEarthquakeMapper: FeatureToEarthquakeMapper
    private let pageSize = 20
    
    init(getEarthquakesUseCase: GetEarthquakesUseCase,
         featureToEarthquakeMapper: FeatureToEarthquakeMapper) {
        self.getEarthquakesUseCase = getEarthquakesUseCase
        self.featureToEarthquakeMapper = featureToEarthquakeMapper
    }
    
    // GET PAGINATED EARTHQUAKES
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
    
    //        /*if (isFiltering) {
    //         do {
    //         earthquakes = try await getEarthquakesUseCase.getFilteredEarthquakesByDate(selectedDates: <#T##[Date]#>)
    //         } catch(let error) {
    //         self.error = error
    //         }
    //
    //         isLoading = false
    //         } else {
    //         do {
    //         earthquakes = try await getEarthquakesUseCase.getLatestEarthquakes(offset: offset, pageSize: 20)
    //         } catch(let error) {
    //         self.error = error
    //         }
    //
    //         isLoading = false
    //         }*/
    //    }
    
    /*private func getFilteredEarthquakesByDate(selectedDates: [Date]) {
     self.selectedDates = selectedDates
     isFiltering = true
     print(selectedDates[0])
     print(selectedDates[1])
     
     let formatter = DateFormatter()
     formatter.dateStyle = .medium
     formatter.timeStyle = .none
     let date1 = formatter.string(from: selectedDates[0])
     let date2 = formatter.string(from: selectedDates[1])
     print(date1)
     print(date2)
     
     let offset = pageNumber * remoteService.Constants.pageSize + 1
     
     let leftDate = selectedDates[0]
     let rightDate = date1 == date2 ? nil : selectedDates[1]
     
     getEarthquakesUseCase.getEarthquakesBetweenDates(leftDate, rightDate, offset: offset, pageSize: 20)
     
     if self.isPaginating {
     self.filteredEarthquakes.append(contentsOf: mappedEarthquakes)
     } else {
     self.filteredEarthquakes = mappedEarthquakes
     }
     self.hasMoreData = !(mappedEarthquakes.count < EarthquakesApiDataSource.Constants.pageSize)
     print("FILTERING: Returned \(features.count). Paginating: \(self.isPaginating). HasMoreData: \(self.hasMoreData)")
     self.viewDelegate?.updateView()
     }
     
     
     // MARK: - Filtering
     func filterEarthquakesByDate(selectedDates: [Date]) {
     isPaginating = false
     pageNumber = 0
     getFilteredEarthquakesByDate(selectedDates: selectedDates)
     }
     
     func endFiltering() {
     isFiltering = false
     }*/
    
    // MARK: - Ordering
    /*func orderFeaturesByMagnitude() {
     inIncreasingOrder = !inIncreasingOrder
     if (isFiltering) {
     filteredEarthquakes.sort(by: { inIncreasingOrder ? $0.formattedMagnitude < $1.formattedMagnitude : $0.formattedMagnitude > $1.formattedMagnitude })
     } else {
     earthquakesData.sort(by: { inIncreasingOrder ? $0.formattedMagnitude < $1.formattedMagnitude : $0.formattedMagnitude > $1.formattedMagnitude })
     }
     self.viewDelegate?.updateView()
     }
     
     func orderFeaturesByPlace() {
     if (!inIncreasingOrder) {
     if (isFiltering) {
     filteredEarthquakes.sort(by: { $0.simplifiedTitle.lowercased().folding(options: .diacriticInsensitive, locale: Locale.current) < $1.simplifiedTitle.lowercased().folding(options: .diacriticInsensitive, locale: Locale.current) })
     inIncreasingOrder = true
     } else {
     earthquakesData.sort(by: { $0.simplifiedTitle.lowercased().folding(options: .diacriticInsensitive, locale: Locale.current) < $1.simplifiedTitle.lowercased().folding(options: .diacriticInsensitive, locale: Locale.current) })
     inIncreasingOrder = true
     }
     self.viewDelegate?.updateView()
     } else {
     if (isFiltering) {
     filteredEarthquakes.sort(by: { $1.simplifiedTitle.lowercased().folding(options: .diacriticInsensitive, locale: Locale.current) < $0.simplifiedTitle.lowercased().folding(options: .diacriticInsensitive, locale: Locale.current) })
     inIncreasingOrder = false
     } else {
     earthquakesData.sort(by: { $1.simplifiedTitle.lowercased().folding(options: .diacriticInsensitive, locale: Locale.current) < $0.simplifiedTitle.lowercased().folding(options: .diacriticInsensitive, locale: Locale.current) })
     inIncreasingOrder = false
     }
     self.viewDelegate?.updateView()
     }
     }
     
     func orderFeaturesByDate() {
     if (!inIncreasingOrder) {
     if (isFiltering) {
     filteredEarthquakes.sort(by: { $0.originalDate < $1.originalDate })
     inIncreasingOrder = true
     } else {
     earthquakesData.sort(by: { $0.originalDate < $1.originalDate })
     inIncreasingOrder = true
     }
     self.viewDelegate?.updateView()
     } else {
     if (isFiltering) {
     filteredEarthquakes.sort(by: { $1.originalDate < $0.originalDate })
     inIncreasingOrder = false
     } else {
     earthquakesData.sort(by: { $1.originalDate < $0.originalDate })
     inIncreasingOrder = false
     }
     self.viewDelegate?.updateView()
     }
     }*/
}
