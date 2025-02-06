//
//  CatViewModelTests.swift
//  CatBrowser
//
//  Created by Riyad Anabtawi on 03/02/25.
//
import XCTest

@testable import CatBrowser

class CatViewModelTests: XCTestCase {
    func testFetchCatsSuccess() {
        let mockAPIManager = MockAPIManager()
        let catManager = CatManager(apiManager: mockAPIManager)
        let viewModel = CatViewModel(catManager: catManager)

        viewModel.fetchCats()

        XCTAssertFalse(viewModel.cats.isEmpty, "Expected cats to be fetched, but got an empty array")
        XCTAssertEqual(viewModel.cats.count, 2, "Expected 2 cats, but got \(viewModel.cats.count)")
        XCTAssertEqual(viewModel.cats.first?.id, "1")
    }

    func testFetchCatsFailure() {
        let mockAPIManager = MockAPIManager(shouldFail: true)
        let catManager = CatManager(apiManager: mockAPIManager)
        let viewModel = CatViewModel(catManager: catManager)

        viewModel.fetchCats()

        XCTAssertTrue(viewModel.cats.isEmpty, "Expected no cats to be fetched on failure")
    }

    func testFetchCatsEmptyResponse() {
        let mockAPIManager = MockAPIManager(mockCats: [])
        let catManager = CatManager(apiManager: mockAPIManager)
        let viewModel = CatViewModel(catManager: catManager)

        viewModel.fetchCats()

        XCTAssertTrue(viewModel.cats.isEmpty, "Expected empty cats list when no data is returned")
    }
}

// Mock API Manager that doesn’t use Alamofire
class MockAPIManager: APIManagerProtocol {
    private var mockCats: [Cat]
    private var shouldFail: Bool

    init(mockCats: [Cat] = [
        Cat(id: "1", url: "https://example.com/cat1.jpg", breeds: []),
        Cat(id: "2", url: "https://example.com/cat2.jpg", breeds: [])
    ], shouldFail: Bool = false) {
        self.mockCats = mockCats
        self.shouldFail = shouldFail
    }

    func request<T: Decodable>(
        apiRequest: APIRequest<String, T>,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        if shouldFail {
            completion(.failure(NSError(domain: "Mock Error", code: -1, userInfo: nil)))
        } else if let result = mockCats as? T {
            completion(.success(result))
        } else {
            completion(.failure(NSError(domain: "Type Mismatch", code: -2, userInfo: nil)))
        }
    }
}
