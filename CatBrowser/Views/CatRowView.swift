//
//  CatRowView.swift
//  CatBrowser
//
//  Created by Riyad Anabtawi on 03/02/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct CatRowView: View {
    let cat: Cat
    @State private var isVisible = false

    var body: some View {
        HStack(alignment: .top, spacing: 15) {
     
            if let url = URL(string: cat.url) {
                WebImage(url: url)
                    .resizable()
                    .placeholder(Image("PlaceholderImage"))
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100) // Square image
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .opacity(isVisible ? 1 : 0)
                    .scaleEffect(isVisible ? 1 : 0.8)
                    .animation(.easeOut(duration: 0.5), value: isVisible)
                    .clipped()
            } else {
                Image("PlaceholderImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .clipped()
            }

            
            VStack(alignment: .leading, spacing: 5) {
         
                Text(cat.breeds?.first?.name ?? "Unknown Breed")
                    .font(.headline)
                    .lineLimit(1)

              
                if let origin = cat.breeds?.first?.origin {
                    Text("🌍 \(origin)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

               
                if let temperament = cat.breeds?.first?.temperament {
                    Text("🎭 \(temperament)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil) // Show full text
                }
            }

            Spacer() 
        }
        .padding(.vertical, 8)
        .onAppear {
            isVisible = true
        }
    }
}
