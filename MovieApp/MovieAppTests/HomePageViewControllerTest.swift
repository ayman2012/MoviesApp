//
//  HomePageViewControllerTest.swift
//  MovieAppTests
//
//  Created by Ayman Fathy on 6/17/19.
//  Copyright © 2019 Instabug Inc. All rights reserved.
//

import XCTest
@testable import MovieApp

class HomePageViewControllerTest: XCTestCase {

  func  test_setupViewController() {
    let homePageView = HomePageViewController()
    homePageView.loadView()
    let movie = MoviesItem.init(title: "title", releaseDate: "releaseDate", overview: "", posterPath: "posterPath", isLocalData: true)
    CoreDataManager.shared.saveMovie(model: movie)
    }
    func  test_navigateToDetailsPage() {
        let homePageView = HomePageViewController()
        homePageView.loadView()
        let movie = MoviesItem.init(title: "title", releaseDate: "releaseDate", overview: "", posterPath: "posterPath", isLocalData: true)
        homePageView.navigateToDetailsPage(dataModel: movie)
    }
}
