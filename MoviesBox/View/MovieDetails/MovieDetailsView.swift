//
//  MovieDetailsView.swift
//  MoviesBox
//
//  Created by Priyanka Saroha on 12/1/18.
//  Copyright © 2018 Priyanka Saroha. All rights reserved.
//

import UIKit
import CoreData

class MovieDetailsView: UIView {
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    var movie: Movie!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // To show data in MovieDetailsView
    
    func showData() {
        // Show favorite selected if movie is favorite
        favoriteButton.isSelected = movie.isFavorite
        
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        voteAverageLabel.text = "\(movie.voteAverage)"
        overviewTextView.text = movie.overview
        
        // Check for poster image data
        // if data available then assign to imageview
        // else load from service
        guard let posterImageData = movie.posterImageData else {
            // call to load image from service
            loadPosterFromService()
            return
        }
        posterImageView.image = UIImage(data: posterImageData)
    }
    
    // To fetch poster data either from DB or Service.
    
    func loadPosterFromService() {
        guard let thumbnailPath = movie.thumbnailPath else { return  }
        MoviesServiceHandler().posterImageForPath(path: thumbnailPath, completion: {imageData,error   in
            guard let posterImageData = imageData , error == nil else {
                print("Poster download failed with error: \(error!)")
                return
            }
            DispatchQueue.main.async {[unowned self] in
                self.posterImageView.image = UIImage(data: posterImageData)

                // cache image data in Movie to use once downloaded
                self.movie.posterImageData = posterImageData
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
            }
        })
    }
    
    
    // MARK: - Actions
    
    /// To add/ remove movie from favorite.
    /// - Parameter sender: UIButton to make movie favorite/ unfavorite.
    
    @IBAction func favoriteTapped(_ sender: UIButton) {
        // Toggle favorite button state
        sender.isSelected = !sender.isSelected
        
        // Update favorite flag for Movie
        movie.isFavorite = sender.isSelected
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
}
