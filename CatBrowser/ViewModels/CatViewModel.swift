//
//  CatViewModel.swift
//  CatBrowser
//
//  Created by Riyad Anabtawi on 03/02/25.
//

import Foundation
import Combine

class CatViewModel: ObservableObject {
    
    @Published var cats: [Cat] = []
    @Published var searchText: String = ""
    @Published var selectedWikipediaURL: IdentifiableURL?
    
    private var service: CatServiceProtocol
    private var allCats: [Cat] = []
    private var page = 1
    private var isLoading = false
    private var cancellables = Set<AnyCancellable>()

    init(service: CatServiceProtocol = APIService.shared) {
        self.service = service
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.cats = self?.filterCats() ?? []
            }
            .store(in: &cancellables)
    }

    func fetchCats() {
        guard !isLoading else { return }
        isLoading = true
        APIService.shared.fetchCats(page: page) { result in
            switch result {
            case .success(let newCats):
                self.allCats.append(contentsOf: newCats)
                self.cats = self.filterCats()
                self.page += 1
            case .failure(let error):
                print("Error fetching cats: \(error.localizedDescription)")
            }
            self.isLoading = false
        }
    }

    func filterCats() -> [Cat] {
        guard !searchText.isEmpty else { return allCats }
        return allCats.filter { cat in
            cat.breeds?.first?.name.lowercased().contains(searchText.lowercased()) ?? false
        }
    }
    
    func openWikipedia(for cat: Cat) {
            guard let urlString = cat.breeds?.first?.wikipedia_url,
                  let url = URL(string: urlString) else {
                return
            }
            selectedWikipediaURL = IdentifiableURL(url: url)
    }
    
}

struct IdentifiableURL: Identifiable {
    let id = UUID()
    let url: URL
}
