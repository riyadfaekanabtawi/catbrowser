//
//  Breed.swift
//  CatBrowser
//
//  Created by Riyad Anabtawi on 03/02/25.
//

import Foundation

struct Breed: Codable, Equatable {
    let id: String
    let name: String
    let weight: Weight
    let temperament: String
    let origin: String
    let life_span: String
    let wikipedia_url: String?
}

struct Weight: Codable, Equatable {
    let imperial: String
    let metric: String
}
