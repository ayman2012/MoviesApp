//
//  DetailsPageViewControllerTest.swift
//  MovieAppTests
//
//  Created by Ayman Fathy on 6/17/19.
//  Copyright © 2019 Instabug Inc. All rights reserved.
//

import XCTest
@testable import MovieApp
class DetailsPageViewControllerTest: XCTestCase {

    func  test_setupViewController() {
        let detailsPageView = DetailsPageViewController()
        detailsPageView.viewDidLoad()
    }
    func  test_setupViewWithData() {
        let detailsPageView = DetailsPageViewController()
        detailsPageView.loadView()
//        let localContainer = UIView(frame:someFrame)
//        let controllerUnderTest = //instantiate your controller
//            localContainer.addSubview(controllerUnderTest.view)

        let movie = MoviesItem.init(title: "title", releaseDate: "releaseDate", overview: "", posterPath: "posterPath", isLocalData: true)
        detailsPageView.setupViewWithData(model: movie)
    }

}
