//
//  MoviesDataHandler.swift
//  MoviesBox
//
//  Created by Priyanka Saroha on 12/2/18.
//  Copyright © 2018 Priyanka Saroha. All rights reserved.
//

import Foundation
import CoreData

class MoviesDataHandler {
    
    let persistentContainer: NSPersistentContainer!
    
    //MARK: Init with dependency
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    convenience init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.init(container: appDelegate.persistentContainer)
    }
    
    /// Fetch movies list for given tyoe from DB.
    ///
    /// - Parameter type: Type of movie i.e Now Playing or Top Rated
    /// - Returns: List of Movie objects.
    
    func moviesList(for type: MovieType) -> [Movie] {
        let context = persistentContainer.viewContext
        let model = persistentContainer.managedObjectModel
        let request = model.fetchRequestTemplate(forName: type.fetchRequestName())!
        let results = try! context.fetch(request)
        return results as! [Movie]
    }
    
}
