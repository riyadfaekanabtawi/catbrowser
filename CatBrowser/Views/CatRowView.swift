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

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: cat.url)) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}
