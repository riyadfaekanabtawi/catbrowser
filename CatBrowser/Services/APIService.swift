//
//  APIService.swift
//  CatBrowser
//
//  Created by Riyad Anabtawi on 03/02/25.
//

import Foundation

class APIService {
    static let shared = APIService()

    func fetchCats(page: Int, completion: @escaping (Result<[Cat], Error>) -> Void) {
        let urlString = "\(AppConstants.baseURL)\(AppConstants.imageSearchEndpoint)?limit=10&has_breeds=1&page=\(page)"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.addValue(AppConstants.apiKey, forHTTPHeaderField: "x-api-key")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data = data else { return }
            do {
                let cats = try JSONDecoder().decode([Cat].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(cats))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
