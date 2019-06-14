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
    let results: [Result2]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
    
    init(page: Int?, totalResults: Int?, totalPages: Int?, results: [Result2]?) {
        self.page = page
        self.totalResults = totalResults
        self.totalPages = totalPages
        self.results = results
    }
}

// MARK: - Result
struct Result2: Codable{
    let title: String?
    let posterPath: String?
    let overview: String?
    let releaseDate: String?
    enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
    }
    init(title: String?, posterPath: String?, overview: String?, releaseDate: String?) {
        self.title = title
        self.posterPath = posterPath
        self.overview = overview
        self.releaseDate = releaseDate
    }
}

