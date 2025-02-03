//
//  CatViewModelTests.swift
//  CatBrowser
//
//  Created by Riyad Anabtawi on 03/02/25.
//

import Foundation

import XCTest
@testable import CatBrowser

class CatViewModelTests: XCTestCase {
    
    func testFetchCatsSuccess() {
        let mockService = MockCatService()
        mockService.mockCats = [
            Cat(id: "1", url: "https://example.com/cat1.jpg", breeds: []),
            Cat(id: "2", url: "https://example.com/cat2.jpg", breeds: [])
        ]
        let viewModel = CatViewModel(service: mockService)

        viewModel.fetchCats()

        XCTAssertEqual(viewModel.cats.count, 2)
        XCTAssertEqual(viewModel.cats.first?.id, "1")
    }
    
    func testFetchCatsFailure() {
        let mockService = MockCatService()
        mockService.shouldFail = true
        let viewModel = CatViewModel(service: mockService)

        viewModel.fetchCats()

        XCTAssertTrue(viewModel.cats.isEmpty)
    }
}


class MockCatService: CatServiceProtocol {
    var mockCats: [Cat] = []
    var shouldFail: Bool = false

    func fetchCats(page: Int, completion: @escaping (Result<[Cat], Error>) -> Void) {
        if shouldFail {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock Error"])))
        } else {
            completion(.success(mockCats))
        }
    }
}
