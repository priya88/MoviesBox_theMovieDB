//
//  Movie+CoreDataClass.swift
//  MoviesBox
//
//  Created by Priyanka Saroha on 11/30/18.
//  Copyright © 2018 Priyanka Saroha. All rights reserved.
//
//


import Foundation
import CoreData
import UIKit

@objc(Movie)
public class Movie: NSManagedObject, Codable {
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case overview = "overview"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case thumbnailPath = "poster_path"
    }
    
    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
            fatalError("Failed to get context")
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context) else {
            fatalError("Failed to decode Movie")
        }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        self.voteAverage = try container.decodeIfPresent(Float.self, forKey: .voteAverage) ?? 0.0
        self.thumbnailPath = try container.decodeIfPresent(String.self, forKey: .thumbnailPath)

    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(overview, forKey: .overview)
        try container.encode(releaseDate, forKey: .releaseDate)
        try container.encode(voteAverage, forKey: .voteAverage)
        try container.encode(thumbnailPath, forKey: .thumbnailPath)
    }
}
