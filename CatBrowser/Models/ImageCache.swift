//
//  ImageCache.swift
//  CatBrowser
//
//  Created by Riyad Anabtawi on 03/02/25.
//

import Foundation
import SwiftUI

class ImageCache {
    static let shared = NSCache<NSURL, UIImage>()

    static func getImage(for url: URL) -> UIImage? {
        return shared.object(forKey: url as NSURL)
    }

    static func saveImage(_ image: UIImage, for url: URL) {
        shared.setObject(image, forKey: url as NSURL)
    }
}
