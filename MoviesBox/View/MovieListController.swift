//
//  ViewController.swift
//  MoviesBox
//
//  Created by Priyanka Saroha on 11/30/18.
//  Copyright © 2018 Priyanka Saroha. All rights reserved.
//

import UIKit

class MovieListController: UIViewController {
    
    @IBOutlet weak var movieCarouselView: iCarousel!
    
    var moviesList = [Movie]()
    var movieListpresenter: MovieListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieCarouselView.type = .coverFlow2
        movieListpresenter = MovieListPresenter(withService: MoviesServiceHandler(), dataHandler: MoviesDataHandler(), attachView: self)
        movieListpresenter.loadMovies(for: .nowPlaying)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}


extension MovieListController: iCarouselDataSource, iCarouselDelegate {
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return moviesList.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var movieDetailsView: MovieDetailsView
        
        //reuse view if available, otherwise create a new view
        if let movieView = view as? MovieDetailsView {
            movieDetailsView = movieView
        } else {
            movieDetailsView = Bundle.main.loadNibNamed("MovieDetailsView", owner: self, options: nil)?.last as! MovieDetailsView
            movieDetailsView.frame = CGRect(x: 0, y: 0, width: carousel.frame.width-50, height: carousel.frame.height)
        }
        movieDetailsView.movie = moviesList[index]
        movieDetailsView.showData()
        return movieDetailsView
    }
    
}

extension MovieListController: MovieListView {
    
    func showErrorAlert(with errorMessage: String) {
        let errorAlert = UIAlertController(title: MOVIE_FETCH_FAIL_ALERT_TITLE, message: errorMessage, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(errorAlert, animated: true)
    }
    
    func showMovies(movies: [Movie]) {
        moviesList = movies
        
        // Reload carousel once movie list available
        movieCarouselView.reloadData()
        movieCarouselView.currentItemIndex = 0
    }
    
}
