//
//  CachedAsyncImage.swift
//  CatBrowser
//
//  Created by Riyad Anabtawi on 03/02/25.
//

import Foundation
import SwiftUI

struct CachedAsyncImage: View {
    let url: URL
    @State private var uiImage: UIImage?

    var body: some View {
        Group {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else {
                ProgressView()
                    .onAppear {
                        loadImage()
                    }
            }
        }
    }

    private func loadImage() {
        if let cachedImage = ImageCache.getImage(for: url) {
            self.uiImage = cachedImage
        } else {
            Task {
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    if let image = UIImage(data: data) {
                        ImageCache.saveImage(image, for: url)
                        self.uiImage = image
                    }
                } catch {
                    print("Failed to load image: \(error.localizedDescription)")
                }
            }
        }
    }
}
