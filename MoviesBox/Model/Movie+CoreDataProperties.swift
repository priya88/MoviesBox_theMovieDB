//
//  Movie+CoreDataProperties.swift
//  MoviesBox
//
//  Created by Priyanka Saroha on 11/30/18.
//  Copyright © 2018 Priyanka Saroha. All rights reserved.
//
//

import Foundation
import CoreData

extension CodingUserInfoKey {
    /// Required. Must be an NSManagedObjectContext.
    static let context = CodingUserInfoKey(rawValue: "context")!
    /// Optional. Boolean. If present and true, newly created objects are not inserted into the context.
    static let deferInsertion = CodingUserInfoKey(rawValue: "deferInsertion")!
}

struct RawResponse: Codable {
    let results: [Movie]?
}

extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var overview: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var voteAverage: Float
    @NSManaged public var thumbnailPath: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var type: String?
    @NSManaged public var posterImageData: Data?
}
