//
//  MovieDBService.swift
//  MoviesBox
//
//  Created by Priyanka Saroha on 12/1/18.
//  Copyright © 2018 Priyanka Saroha. All rights reserved.
//

import Foundation
import CoreData

class MoviesServiceHandler {
    
    /// Fetch Movies List from server for provided movie type.
    ///
    /// - Parameter type: Type of movie i.e Now Playing or Top Rated
    /// - Parameter completion: Completion handler to pass movie
    
    func fetchMoviesList(forType type: MovieType, completion: @escaping (_ result: [Movie]?, _ error: String?) -> Void ) {
        guard Reachability.isConnectedToNetwork() else {
            completion(nil, NO_NETWORK_ERROR)
            return
        }
        
        let moviesListURL = URL(string: String(format: MOVIE_LIST_URL, type.rawValue, API_KEY).addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        )
        
        URLSession.shared.dataTask(with: moviesListURL!) { (data, response, error) in
            guard let serverData = data else {
                completion(nil, error?.localizedDescription)
                return
            }
            DispatchQueue.main.async {
                let decoder = JSONDecoder()
                decoder.userInfo[.context] = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                if let rawResponseFromServer = try? decoder.decode(RawResponse.self, from: serverData) {
                    for movie in rawResponseFromServer.results! {
                        movie.type = type.rawValue
                    }
                    completion(rawResponseFromServer.results!, error?.localizedDescription)
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                }
            }
            }.resume()
    }
    
    /// Download poster image from server.
    ///
    /// - Parameter path: Path of poster at server
    /// - Parameter completion: Completion handler to pass downloaded imagedata.
    /// - Parameter result: Movie Poster Image Data.
    /// - Parameter error: Localized error string.
    
    func posterImageForPath(path: String, completion: @escaping (_ result: Data?, _ error:  String?) -> Void) {
        URLSession.shared.dataTask(with: URL(string: BASE_MOVIE_POSTER_URL + path)!) { (data, response, error) in
            completion(data ?? nil, error?.localizedDescription)
            }.resume()
    }
}

