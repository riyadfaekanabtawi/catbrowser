//
//  CatRowView.swift
//  CatBrowser
//
//  Created by Riyad Anabtawi on 03/02/25.
//

import Foundation
import SwiftUI

struct CatRowView: View {
    let cat: Cat
    @State private var isVisible = false

    var body: some View {
        VStack(alignment: .leading) {
            if let url = URL(string: cat.url) {
                CachedAsyncImage(url: url)
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .opacity(isVisible ? 1 : 0)
                    .scaleEffect(isVisible ? 1 : 0.8)
                    .animation(.easeOut(duration: 0.5), value: isVisible)
            }
        }
        .onAppear {
            isVisible = true
        }
    }
}
