//
//  MovieDetailsViewTests.swift
//  MoviesBoxTests
//
//  Created by Priyanka Saroha on 12/3/18.
//  Copyright © 2018 Priyanka Saroha. All rights reserved.
//

import XCTest
@testable import MoviesBox

class MovieDetailsViewTests: XCTestCase {

    var movieDetailsView: MovieDetailsView?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let bundle = Bundle(for: MovieDetailsView.self)
        movieDetailsView = bundle.loadNibNamed("MovieDetailsView", owner: nil)?.first as? UIView as? MovieDetailsView
        XCTAssertNotNil(movieDetailsView)
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
        XCTAssertNotNil(movieDetailsView?.favoriteButton)
        XCTAssertNotNil(movieDetailsView?.posterImageView)
        XCTAssertNotNil(movieDetailsView?.titleLabel)
        XCTAssertNotNil(movieDetailsView?.releaseDateLabel)
        XCTAssertNotNil(movieDetailsView?.voteAverageLabel)
        XCTAssertNotNil(movieDetailsView?.overviewTextView)
    }

}
