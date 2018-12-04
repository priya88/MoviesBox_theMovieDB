//
//  MovieDataHandlerTests.swift
//  MoviesBoxTests
//
//  Created by Priyanka Saroha on 12/3/18.
//  Copyright © 2018 Priyanka Saroha. All rights reserved.
//

import XCTest
@testable import MoviesBox
import CoreData

class MovieDataHandlerTests: XCTestCase {
    var moviesDataHandler: MoviesDataHandler?
    
    var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        return managedObjectModel
    }()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MoviesBoxTest", managedObjectModel: managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
            
            // Check if creating container wrong
            if let error = error {
                fatalError("In memory coordinator creation failed \(error)")
            }
        }
        return container
    }()
    
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        moviesDataHandler = MoviesDataHandler(container: mockPersistantContainer)
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
    
    func testMoviesListForNowPlayingType() {
        createMockMovies(for: MovieType.nowPlaying)
        
        let fetchedNowPlayingMovies = moviesDataHandler?.moviesList(for: MovieType.nowPlaying)
        XCTAssertTrue(fetchedNowPlayingMovies!.count > 0)
    }
    
    func testMoviesListForToRatedType() {
        createMockMovies(for: MovieType.topRated)
        
        let fetchedTopRatedMovies = moviesDataHandler?.moviesList(for: MovieType.topRated)
        XCTAssertTrue(fetchedTopRatedMovies!.count > 0)
    }

    func createMockMovies(for type: MovieType){
        let url = Bundle.main.url(forResource: "DummyMovies", withExtension: "json")
        do {
            let data = try Data(contentsOf: url!)
            let decoder = JSONDecoder()
            decoder.userInfo[.context]  = moviesDataHandler?.persistentContainer.viewContext
            let rawResponse = try decoder.decode(RawResponse.self, from: data)
            for movie in rawResponse.results! {
                movie.type = type.rawValue
            }
            try moviesDataHandler?.persistentContainer.viewContext.save()
        } catch {
            print("error:\(error)")
        }
    }
    
}
