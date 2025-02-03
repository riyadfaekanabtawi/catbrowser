//
//  Cat.swift
//  CatBrowser
//
//  Created by Riyad Anabtawi on 03/02/25.
//

import Foundation

struct Cat: Identifiable, Codable {
    let id: String
    let url: String
    let breeds: [Breed]?
}
