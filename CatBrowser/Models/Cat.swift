//
//  Cat.swift
//  CatBrowser
//
//  Created by Riyad Anabtawi on 03/02/25.
//

import Foundation

struct Cat: Identifiable, Codable, Equatable {
    let id: String
    let url: String
    let breeds: [Breed]?

    static func == (lhs: Cat, rhs: Cat) -> Bool {
        return lhs.id == rhs.id
    }
}
