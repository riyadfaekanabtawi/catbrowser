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
                NavigationLink(destination: CatDetailView(cat: cat)) {
                    CatRowView(cat: cat)
                }
                .onAppear {
                    if cat == viewModel.cats.last {
                        viewModel.fetchCats()
                    }
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Search by breed")
            .onChange(of: viewModel.searchText) {
                viewModel.cats = viewModel.filterCats()
            }

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
