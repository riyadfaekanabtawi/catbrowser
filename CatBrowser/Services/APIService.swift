//
//  APIService.swift
//  CatBrowser
//
//  Created by Riyad Anabtawi on 03/02/25.
//

import Foundation

class APIService {
    static let shared = APIService()
    private let baseURL = "https://api.thecatapi.com/v1/images/search?limit=10&page="
    
    func fetchCats(page: Int, completion: @escaping (Result<[Cat], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)\(page)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
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
