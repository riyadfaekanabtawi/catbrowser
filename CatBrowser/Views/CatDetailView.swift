//
//  CatDetailView.swift
//  CatBrowser
//
//  Created by Riyad Anabtawi on 03/02/25.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct CatDetailView: View {
    let cat: Cat
    @StateObject private var viewModel = CatViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Cat Image Section
                if let url = URL(string: cat.url) {
                    WebImage(url: url)
                        .resizable()
                        .placeholder {
                            Image("PlaceholderImage")
                                .resizable()
                                .scaledToFit()
                        }
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 10)
                }

                // Breed Name
                if let breed = cat.breeds?.first {
                    Text(breed.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)

                    // Breed Information Section
                    VStack(alignment: .leading, spacing: 15) {
                        // Weight
                        HStack {
                            Text("🐾 Weight:")
                                .fontWeight(.semibold)
                            Spacer()
                            Text("\(breed.weight.imperial) lbs (\(breed.weight.metric) kg)")
                        }

                        // Origin
                        HStack {
                            Text("🌍 Origin:")
                                .fontWeight(.semibold)
                            Spacer()
                            Text(breed.origin)
                        }

                        // Life Span
                        HStack {
                            Text("❤️ Life Span:")
                                .fontWeight(.semibold)
                            Spacer()
                            Text("\(breed.life_span) years")
                        }

                        // Temperament
                        VStack(alignment: .leading) {
                            Text("🎭 Temperament:")
                                .fontWeight(.semibold)
                            Text(breed.temperament)
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                        }

                        // Wikipedia Link
                        if let wikipediaURL = breed.wikipedia_url, let url = URL(string: wikipediaURL) {
                            Button(action: {
                                viewModel.selectedWikipediaURL = IdentifiableURL(url: url)
                            }) {
                                Text("📖 Learn more on Wikipedia")
                                    .foregroundColor(.blue)
                                    .underline()
                            }
                        }
                    }
                    .padding(.horizontal) // Add horizontal padding for details section
                } else {
                    Text("No breed information available.")
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                }
            }
            .padding() // Add overall padding to the content
        }
        .navigationTitle("Cat Details")
        .sheet(item: $viewModel.selectedWikipediaURL) { identifiableURL in
            SafariView(url: identifiableURL.url)
        }
    }
}
