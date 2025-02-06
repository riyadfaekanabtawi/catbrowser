//
//  APIManager.swift
//  CatBrowser
//
//  Created by Riyad Anabtawi on 05/02/25.
//

import Foundation
import Alamofire

class APIManager: APIManagerProtocol {
    static let shared = APIManager()
    private let baseURL = AppConstants.baseURL

    func request<T: Codable, U: Codable>(
        apiRequest: APIRequest<T, U>,
        completion: @escaping (Result<U, Error>) -> Void
    ) {
        let url = baseURL + apiRequest.endpoint

      
        var queryParameters = apiRequest.queryParams ?? [:]
        queryParameters["api_key"] = AppConstants.apiKey

        AF.request(
            url,
            method: apiRequest.method,
            parameters: queryParameters,
            headers: HTTPHeaders(apiRequest.headers ?? [:])
        )
        .validate()
        .responseDecodable(of: U.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
