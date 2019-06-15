//
//  HomePageModel.swift
//  MovieApp
//
//  Created by Ayman Fathy on 6/14/19.
//  Copyright © 2019 Instabug Inc. All rights reserved.
//

import Foundation
struct HomePageModel: Codable{
    let page, totalResults, totalPages: Int?
    var results: [Result2]?
    var storedResult: [Result2]?
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
        case storedResult
    }
}

// MARK: - Result
struct Result2: Codable{
    let title: String?
    let posterPath: String?
    let overview: String?
    let releaseDate: String?
    let imageData: Data?
    enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case imageData
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
        imageData  = try values.decodeIfPresent(Data.self, forKey: .imageData)
    }
    init(title:String,releaseDate:String,overview:String,imageData:Data,posterPath:String = "") {
        self.title = title
        self.releaseDate = releaseDate
        self.overview = overview
        self.imageData = imageData
        self.posterPath = posterPath
    }
}

