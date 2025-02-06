//
//  APIManagerProtocol.swift
//  CatBrowser
//
//  Created by Riyad Anabtawi on 05/02/25.
//

import Foundation

protocol APIManagerProtocol {
    func request<T: Decodable>(
        apiRequest: APIRequest<String, T>,
        completion: @escaping (Result<T, Error>) -> Void
    )
}
