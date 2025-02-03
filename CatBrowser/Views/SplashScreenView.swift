//
//  SplashScreenView.swift
//  CatBrowser
//
//  Created by Riyad Anabtawi on 03/02/25.
//

import Foundation
import SwiftUI

import SwiftUI

struct SplashScreenView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isActive = false 

    var body: some View {
        VStack {
           
            Image(colorScheme == .dark ? "SplashLogoDark" : "SplashLogoLight")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .shadow(radius: 10)

        
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .padding(.top, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .ignoresSafeArea()
        .onAppear {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isActive = true
            }
        }
        
        .fullScreenCover(isPresented: $isActive) {
            ContentView()
        }
    }
}
