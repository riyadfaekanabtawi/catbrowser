//
//  CatRequests.swift
//  CatBrowser
//
//  Created by Riyad Anabtawi on 05/02/25.
//

import Foundation

struct CatRequest {
    static func fetchCats(page: Int) -> APIRequest<String, [Cat]> {
        return .init(
            method: .get,
            endpoint: "images/search",
            queryParams: [
                "limit": "10",
                "page": "\(page)",
                "has_breeds": "1"
            ],
            headers: ["x-api-key": AppConstants.apiKey]
        )
    }
}
