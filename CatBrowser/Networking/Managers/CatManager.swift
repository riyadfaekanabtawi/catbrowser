//
//  CatManager.swift
//  CatBrowser
//
//  Created by Riyad Anabtawi on 05/02/25.
//

import Foundation

class CatManager {
private var apiManager: APIManagerProtocol

init(apiManager: APIManagerProtocol = APIManager.shared) {
    self.apiManager = apiManager
}

func getCats(page: Int, completion: @escaping (Result<[Cat], Error>) -> Void) {
    let request = CatRequest.fetchCats(page: page)
    apiManager.request(apiRequest: request) { result in
        completion(result)
    }
}
}
