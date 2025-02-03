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
        let viewModel = CatViewModel(service: mockService)

        viewModel.fetchCats()

        XCTAssertFalse(viewModel.cats.isEmpty, "Expected cats to be fetched, but got an empty array")
        XCTAssertEqual(viewModel.cats.count, 2, "Expected 2 cats, but got \(viewModel.cats.count)")
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
    var mockCats: [Cat] = [
        Cat(id: "1", url: "https://example.com/cat1.jpg", breeds: []),
        Cat(id: "2", url: "https://example.com/cat2.jpg", breeds: [])
    ]
    var shouldFail: Bool = false

    func fetchCats(page: Int, completion: @escaping (Result<[Cat], Error>) -> Void) {
        if shouldFail {
            completion(.failure(NSError(domain: "Mock Error", code: -1, userInfo: nil)))
        } else {
            completion(.success(mockCats))
        }
    }
}
