//
//  CatViewModel.swift
//  CatBrowser
//
//  Created by Riyad Anabtawi on 03/02/25.
//
import Foundation
import Combine

class CatViewModel: ObservableObject {
    // Published properties for UI binding
    @Published var cats: [Cat] = []
    @Published var searchText: String = ""
    @Published var selectedWikipediaURL: IdentifiableURL?
    @Published var isLoading: Bool = false

    private var catManager: CatManager
    private var allCats: [Cat] = []
    private var page: Int = 1
    private var cancellables = Set<AnyCancellable>()

    init(catManager: CatManager = CatManager(apiManager: APIManager.shared)) {
        self.catManager = catManager
        setupSearchDebounce()
    }

    // MARK: - Public Methods

    /// Fetch cats (either for initial load or pagination)
    func fetchCats(isRefreshing: Bool = false) {
        guard !isLoading else { return }

        if isRefreshing {
            resetData()
        }

        isLoading = true
        catManager.getCats(page: page) { [weak self] result in
            self?.handleFetchResult(result: result, isRefreshing: isRefreshing)
        }
    }

    /// Open Wikipedia URL for a specific cat
    func openWikipedia(for cat: Cat) {
        guard let urlString = cat.breeds?.first?.wikipedia_url,
              let url = URL(string: urlString) else { return }
        selectedWikipediaURL = IdentifiableURL(url: url)
    }

    // MARK: - Private Methods

    /// Set up debounced search filtering
    private func setupSearchDebounce() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.cats = self?.filterCats() ?? []
            }
            .store(in: &cancellables)
    }

    /// Reset data for refreshing
    private func resetData() {
        page = 1
        allCats.removeAll()
        cats.removeAll()
    }

    /// Filter cats based on the search text
    private func filterCats() -> [Cat] {
        guard !searchText.isEmpty else { return allCats }
        return allCats.filter { cat in
            cat.breeds?.first?.name.lowercased().contains(searchText.lowercased()) ?? false
        }
    }

    /// Handle the result of the fetch operation
    private func handleFetchResult(result: Result<[Cat], Error>, isRefreshing: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.isLoading = false

            switch result {
            case .success(let newCats):
                if isRefreshing {
                    self.allCats = newCats
                } else {
                    self.allCats.append(contentsOf: newCats)
                }
                self.cats = self.filterCats()
                self.page += 1
            case .failure(let error):
                print("Error fetching cats: \(error.localizedDescription)")
            }
        }
    }
}

struct IdentifiableURL: Identifiable {
    let id = UUID()
    let url: URL
}
