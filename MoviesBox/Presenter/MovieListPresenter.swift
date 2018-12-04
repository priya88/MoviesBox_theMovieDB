//
//  MovieListPresenter.swift
//  MoviesBox
//
//  Created by Priyanka Saroha on 12/1/18.
//  Copyright © 2018 Priyanka Saroha. All rights reserved.
//

import Foundation
import CoreData

enum MovieType: String {
    
    case nowPlaying = "now_playing"
    case topRated = "top_rated"
    
    //MARK: - Fetch request template name for movie type
    
    func fetchRequestName()->String {
        switch self {
        case .nowPlaying:
            return NOWPLAYING_FETCH_REQUEST
        default:
            return TOPRATED_FETCH_REQUEST
        }
    }
    
}

protocol MovieListView: AnyObject {
    
    /// Show movies once data provided by Presenter.
    ///
    /// - Parameter movies: Lsit of Movies from Presenter.
    
    func showMovies(movies: [Movie])
    
    func showErrorAlert(with message: String)
}

class MovieListPresenter {
    
    var moviesDataHandler: MoviesDataHandler
    var moviesServiceHandler: MoviesServiceHandler
    weak var moviesListView: MovieListView?
    
    init(withService service: MoviesServiceHandler, dataHandler: MoviesDataHandler, attachView view: MovieListView) {
        moviesServiceHandler = service
        moviesListView = view
        moviesDataHandler = dataHandler
    }
    
    // MARK: - LoadMovies
    
    /// Load movies from DB or Service.
    ///
    /// - Parameter type: Type of movie i.e Now Playing or Top Rated
    
    func loadMovies(for type: MovieType) {
        let moviesFromDB = moviesDataHandler.moviesList(for: type)
        
        // If no movie in DB for input movie type
        if moviesFromDB.count == 0 {
            // Then fetch movies from service
            moviesServiceHandler.fetchMoviesList(forType: type, completion: { (moviesList,error) in
                if error == nil {
                    // Update view to show movies
                    self.moviesListView?.showMovies(movies: moviesList!)
                } else {
                    // Update view to show movies
                    self.moviesListView?.showErrorAlert(with: error!)
                }
                
            })
        } else {
            // Update view to show movies
            self.moviesListView?.showMovies(movies: moviesFromDB)
        }
    }
    
}
