//
//  MovieListPresenterTests.swift
//  MoviesBoxTests
//
//  Created by Priyanka Saroha on 12/3/18.
//  Copyright © 2018 Priyanka Saroha. All rights reserved.
//

import XCTest
@testable import MoviesBox


fileprivate var emptyMovieList = [MockMovie]()
fileprivate var dummyMoviesList: [MockMovie] {
    var moviesList = [MockMovie]()
    for _ in 0..<20 {
        let movie = MockMovie()
        movie.titleMock = "Title"
        movie.releaseDateMock = "21-11-2018"
        movie.overviewMock = "Overview"
        movie.thumbnailPathMock = "pathForThubnail"
        movie.voteAverageMock = 0.0
        moviesList.append(movie)
    }
    return moviesList
}

fileprivate class MockMovie: Movie {
    var titleMock: String?
    var releaseDateMock: String?
    var overviewMock: String?
    var thumbnailPathMock: String?
    var voteAverageMock: Float?
}

fileprivate class MockMovieListView: MovieListView {
    
    var isShowMoviesCalled = false
    var isShowErrorAlertCalled = false

    func showMovies(movies: [Movie]) {
        isShowMoviesCalled = true
    }
    
    func showErrorAlert(with message: String) {
        isShowErrorAlertCalled = true
    }
    
}

fileprivate class MockMoviesServiceHandler: MoviesServiceHandler {
    
    var moviesList: [MockMovie]!
    var errorMessage: String?
    var isFetchMoviesListCalled = false
    
    override func fetchMoviesList(forType type: MovieType, completion: @escaping (_ result: [Movie]?, _ error: String?) -> Void ) {
        isFetchMoviesListCalled = true
        
        completion(moviesList, errorMessage)
    }
    
    func mockDataForEmptyListWithError() {
        moviesList = emptyMovieList
        errorMessage = "Error occured."
    }
    
    func mockDataForDummyListWithError() {
        moviesList = dummyMoviesList
        errorMessage = nil
    }
}

fileprivate class MockMoviesDataHandler: MoviesDataHandler {
    var moviesList: [MockMovie]!
    
    override func moviesList(for type: MovieType) -> [Movie]  {
        return moviesList
    }
}

class MovieListPresenterTests: XCTestCase {
   
    var movieListPresenter: MovieListPresenter!
    fileprivate var mockMovieListView = MockMovieListView()
    fileprivate var mockMovieServiceHandler = MockMoviesServiceHandler()
    fileprivate var mockMovieListDataHandler = MockMoviesDataHandler()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        movieListPresenter = MovieListPresenter(withService: mockMovieServiceHandler, dataHandler: mockMovieListDataHandler, attachView: mockMovieListView)
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

    func testLoadMovies_FromService_With_Error() {
        mockMovieListDataHandler.moviesList = emptyMovieList
        mockMovieServiceHandler.mockDataForEmptyListWithError()
        
        movieListPresenter.loadMovies(for: MovieType.nowPlaying)
        
        XCTAssertTrue(mockMovieServiceHandler.isFetchMoviesListCalled)
        XCTAssertTrue(mockMovieListView.isShowErrorAlertCalled)
    }
    
    func testLoadMovies_FromService_With_Success() {
        mockMovieListDataHandler.moviesList = emptyMovieList
        mockMovieServiceHandler.mockDataForDummyListWithError()
        
        movieListPresenter.loadMovies(for: MovieType.nowPlaying)
        XCTAssertTrue(mockMovieServiceHandler.isFetchMoviesListCalled)
        XCTAssertTrue(mockMovieListView.isShowMoviesCalled)
    }
    
    func testLoadMovies_FromDB() {
        mockMovieListDataHandler.moviesList = dummyMoviesList
        
        movieListPresenter.loadMovies(for: MovieType.nowPlaying)
        
        XCTAssertFalse(mockMovieServiceHandler.isFetchMoviesListCalled)
        XCTAssertTrue(mockMovieListView.isShowMoviesCalled)
    }
}
