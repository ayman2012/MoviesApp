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
class CoreDataManager{
    static let shared = CoreDataManager()
    private init(){}
    func saveMovie(model:Result2){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
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
    func getMovies()->[Result2]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        _ = NSEntityDescription.entity(forEntityName: "MoviesDataModel", in: context)
        var movies: [Result2] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MoviesDataModel")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
               let title =  data.value(forKey: "title") as! String
               let overView = data.value(forKey: "overView") as! String
               let releaseDate = data.value(forKey: "releaseDate") as! String
               let posterPathUrl = data.value(forKey: "imageURl") as! String
                movies.append(Result2.init(title: title, releaseDate: releaseDate, overview: overView, posterPath: posterPathUrl,isLocalData:true))
            }
        } catch {
            
            print("Failed")
        }
        return movies
    }
}
