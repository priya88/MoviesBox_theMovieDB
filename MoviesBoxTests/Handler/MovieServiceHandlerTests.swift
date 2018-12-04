//
//  MovieServiceHandlerTests.swift
//  MoviesBoxTests
//
//  Created by Priyanka Saroha on 12/3/18.
//  Copyright © 2018 Priyanka Saroha. All rights reserved.
//

import XCTest
@testable import MoviesBox

class MovieServiceHandlerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchMoviesList() {
        let fetchMovieExpectation = expectation(description: "GET Movies")
        MoviesServiceHandler().fetchMoviesList(forType: MovieType.nowPlaying) { (movieList, errorMessage) in
            XCTAssert(errorMessage == nil, "Movies fetched successfully")
            fetchMovieExpectation.fulfill()
        }
        waitForExpectations(timeout: 5){ error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
}
