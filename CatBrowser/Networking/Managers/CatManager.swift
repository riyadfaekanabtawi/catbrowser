//
//  CatManager.swift
//  CatBrowser
//
//  Created by Riyad Anabtawi on 05/02/25.
//

import Foundation
class CatManager {
    private var apiManager: APIManager

    init(apiManager: APIManager = .shared) {
        self.apiManager = apiManager
    }

    func getCats(page: Int, completion: @escaping (Result<[Cat], Error>) -> Void) {
        apiManager.request(apiRequest: CatRequest.fetchCats(page: page)) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let cats):
                completion(.success(cats))
            }
        }
    }
}
