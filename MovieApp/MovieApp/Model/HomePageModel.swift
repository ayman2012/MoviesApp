//
//  HomePageModel.swift
//  MovieApp
//
//  Created by Ayman Fathy on 6/14/19.
//  Copyright © 2019 Instabug Inc. All rights reserved.
//

import Foundation
struct HomePageModel: Codable{
    var results: [Result2]?
    var storedResult: [Result2]?
    enum CodingKeys: String, CodingKey {
        case results
        case storedResult
    }
    init(results:[Result2],storedResult:[Result2]) {
        self.results = results
        self.storedResult = storedResult
    }
}

// MARK: - Result
struct Result2: Codable{
    let title: String?
    var posterPath: String?
    let overview: String?
    let releaseDate: String?
    var isLocalData:Bool?
    enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
    }
    init(title:String,releaseDate:String,overview:String,posterPath:String,isLocalData:Bool) {
        self.title = title
        self.releaseDate = releaseDate
        self.overview = overview
        self.posterPath = posterPath
        self.isLocalData = isLocalData
    }
}


