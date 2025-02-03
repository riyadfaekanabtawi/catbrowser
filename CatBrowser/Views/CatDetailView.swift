//
//  CatDetailView.swift
//  CatBrowser
//
//  Created by Riyad Anabtawi on 03/02/25.
//

import Foundation
import SwiftUI

import SwiftUI

struct CatDetailView: View {
    let cat: Cat
    @StateObject private var viewModel = CatViewModel() // Local ViewModel for managing browser

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: cat.url)) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 10))

                if let breed = cat.breeds?.first {
                    Text(breed.name)
                        .font(.title)
                        .bold()

                    Text("🐾 Weight: \(breed.weight.imperial) lbs (\(breed.weight.metric) kg)")
                    Text("🌍 Origin: \(breed.origin)")
                    Text("❤️ Life Span: \(breed.life_span) years")
                    Text("🎭 Temperament: \(breed.temperament)")

                    if let wikipediaURL = breed.wikipedia_url {
                        Button(action: {
                            viewModel.openWikipedia(for: cat)
                        }) {
                            Text("📖 Learn more on Wikipedia")
                                .foregroundColor(.blue)
                                .underline()
                        }
                    }
                } else {
                    Text("No breed information available.")
                }
            }
            .padding()
        }
        .navigationTitle("Cat Details")
        .sheet(item: $viewModel.selectedWikipediaURL) { identifiableURL in
            SafariView(url: identifiableURL.url) // Extract the raw URL from IdentifiableURL
        }
    }
}
