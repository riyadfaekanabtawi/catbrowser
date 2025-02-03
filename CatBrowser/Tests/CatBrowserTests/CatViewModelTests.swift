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
    
    func testFetchCats() {
        let expectation = XCTestExpectation(description: "Fetch cats")
        let viewModel = CatViewModel()
        
        viewModel.fetchCats()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertFalse(viewModel.cats.isEmpty)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
}
