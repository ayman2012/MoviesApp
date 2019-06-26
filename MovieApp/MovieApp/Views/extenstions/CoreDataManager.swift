//
//  CoreDataManager.swift
//  MovieApp
//
//  Created by Ayman Fathy on 6/16/19.
//  Copyright © 2019 Instabug Inc. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}

    ///save movie in local storage
    func saveMovie(model: MoviesItem) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MoviesDataModel", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(model.title, forKey: "title")
        newUser.setValue(model.overview, forKey: "overView")
        newUser.setValue(model.releaseDate, forKey: "releaseDate")
        newUser.setValue(model.posterPath, forKey: "imageURl")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    ///get array of movies from local storage
    func getMovies() -> [MoviesItem] {
        var movies: [MoviesItem] = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return movies }
        let context = appDelegate.persistentContainer.viewContext
        _ = NSEntityDescription.entity(forEntityName: "MoviesDataModel", in: context)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MoviesDataModel")
        request.returnsObjectsAsFaults = false
        do {
            guard let result = try context.fetch(request) as? [NSManagedObject] else { return movies}
            for data in result {
               let title =  data.value(forKey: "title") as? String
               let overView = data.value(forKey: "overView") as? String
               let releaseDate = data.value(forKey: "releaseDate") as? String
               let posterPathUrl = data.value(forKey: "imageURl") as? String
                movies.append(MoviesItem.init(title: title ?? "", releaseDate: releaseDate ?? "", overview: overView ?? "", posterPath: posterPathUrl ?? "", isLocalData: true ))
            }
        } catch {

            print("Failed")
        }
        return movies
    }
}
