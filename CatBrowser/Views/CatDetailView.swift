//
//  CatDetailView.swift
//  CatBrowser
//
//  Created by Riyad Anabtawi on 03/02/25.
//
import Foundation
import SwiftUI

struct CatDetailView: View {
    let cat: Cat
    @StateObject private var viewModel = CatViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
      
                if let url = URL(string: cat.url) {
                    CachedAsyncImage(url: url)
                        .frame(height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 10)
                        .padding(.bottom, 10)
                }

                if let breed = cat.breeds?.first {
                    Text(breed.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)

                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("🐾 Weight:")
                                .fontWeight(.semibold)
                            Spacer()
                            Text("\(breed.weight.imperial) lbs (\(breed.weight.metric) kg)")
                        }

                        HStack {
                            Text("🌍 Origin:")
                                .fontWeight(.semibold)
                            Spacer()
                            Text(breed.origin)
                        }

                        HStack {
                            Text("❤️ Life Span:")
                                .fontWeight(.semibold)
                            Spacer()
                            Text("\(breed.life_span) years")
                        }

                        VStack(alignment: .leading) {
                            Text("🎭 Temperament:")
                                .fontWeight(.semibold)
                            Text(breed.temperament)
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                        }

                        if breed.wikipedia_url != nil {
                            Button(action: {
                                viewModel.openWikipedia(for: cat)
                            }) {
                                Text("📖 Learn more on Wikipedia")
                                    .foregroundColor(.blue)
                                    .underline()
                            }
                        }
                    }
                } else {
                    Text("No breed information available.")
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
        .navigationTitle("Cat Details")
        .sheet(item: $viewModel.selectedWikipediaURL) { identifiableURL in
            SafariView(url: identifiableURL.url)
        }
    }
}
