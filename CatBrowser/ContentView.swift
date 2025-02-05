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
            ZStack {
                // ✅ List of Cats
                List(viewModel.cats) { cat in
                    NavigationLink(destination: CatDetailView(cat: cat)
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))) {
                        CatRowView(cat: cat)
                            .accessibilityIdentifier("CatRow_\(cat.id)")
                    }
                    .onAppear {
                        if cat == viewModel.cats.last {
                            viewModel.fetchCats() // Pagination
                        }
                    }
                }
                .refreshable {
                    viewModel.fetchCats(isRefreshing: true) // Pull-to-refresh
                }
                .searchable(text: $viewModel.searchText, prompt: "Search by breed")
                .navigationTitle("Cat Browser")

                // ✅ Activity Indicator for Loading
                if viewModel.isLoading && viewModel.cats.isEmpty {
                    VStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .scaleEffect(2.0) // Make the spinner larger
                            .padding()

                        Text("Loading cats...")
                            .foregroundColor(.gray)
                            .font(.headline)
                            .padding(.top, 10)
                    }
                    .padding(30)
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(15)
                    .shadow(radius: 10)
                }
            }
            .onAppear {
                viewModel.fetchCats() // Initial Fetch
            }
        }
    }
}

#Preview {
    ContentView()
}
