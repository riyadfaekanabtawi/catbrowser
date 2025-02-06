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
        // Expectation for successful fetch
        let expectation = XCTestExpectation(description: "Fetch cats succeeds")
        
        // Setup Mock API Manager and dependencies
        let mockAPIManager = MockAPIManager()
        let catManager = CatManager(apiManager: mockAPIManager)
        let viewModel = CatViewModel(catManager: catManager)

        // Call fetchCats
        viewModel.fetchCats()

        // Wait and assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(viewModel.cats.isEmpty, "Expected cats to be fetched, but got an empty array")
            XCTAssertEqual(viewModel.cats.count, 2, "Expected 2 cats, but got \(viewModel.cats.count)")
            XCTAssertEqual(viewModel.cats.first?.id, "1", "Expected first cat ID to be '1', but got \(String(describing: viewModel.cats.first?.id))")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

    func testFetchCatsFailure() {
        // Expectation for failed fetch
        let expectation = XCTestExpectation(description: "Fetch cats fails")
        
        // Setup Mock API Manager with failure
        let mockAPIManager = MockAPIManager(shouldFail: true)
        let catManager = CatManager(apiManager: mockAPIManager)
        let viewModel = CatViewModel(catManager: catManager)

        // Call fetchCats
        viewModel.fetchCats()

        // Wait and assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(viewModel.cats.isEmpty, "Expected no cats to be fetched on failure")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

    func testFetchCatsEmptyResponse() {
        // Expectation for empty response
        let expectation = XCTestExpectation(description: "Fetch cats with empty response")
        
        // Setup Mock API Manager with empty response
        let mockAPIManager = MockAPIManager(mockCats: [])
        let catManager = CatManager(apiManager: mockAPIManager)
        let viewModel = CatViewModel(catManager: catManager)

        // Call fetchCats
        viewModel.fetchCats()

        // Wait and assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(viewModel.cats.isEmpty, "Expected empty cats list when no data is returned")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
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
