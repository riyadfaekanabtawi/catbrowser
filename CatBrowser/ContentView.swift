//
//  ContentView.swift
//  CatBrowser
//
//  Created by Riyad Anabtawi on 03/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CatViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.cats) { cat in
                NavigationLink(destination: CatDetailView(cat: cat)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))) {
                    CatRowView(cat: cat)
                            .accessibilityIdentifier("CatRow_\(cat.id)")
                }
                .onAppear {
                    if cat == viewModel.cats.last {
                        viewModel.fetchCats()
                    }
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Search by breed")
            .navigationTitle("Cat Browser")
            .onAppear {
                viewModel.fetchCats()
            }
        }
    }
}

#Preview {
    ContentView()
}
