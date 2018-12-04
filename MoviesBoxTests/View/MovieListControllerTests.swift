//
//  MovieListControllerTests.swift
//  MoviesBoxTests
//
//  Created by Virupaksh Futane on 12/4/18.
//  Copyright © 2018 Virupaksha futane. All rights reserved.
//

import XCTest
@testable import MoviesBox

class MovieListControllerTests: XCTestCase {
    
    var movieListController: MovieListController?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyBoard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        movieListController = storyBoard.instantiateInitialViewController() as? MovieListController
        movieListController?.loadView()
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
    
    func testOutlets() {
        XCTAssertNotNil(movieListController?.movieCarouselView)
    }

}
