//
//  NewMovieViewController.swift
//  MovieAppTests
//
//  Created by Ayman Fathy on 6/17/19.
//  Copyright © 2019 Instabug Inc. All rights reserved.
//

import XCTest
@testable import MovieApp
class NewMovieViewControllerTest: XCTestCase {

    func  test_setupViewController() {
        let newMovieView = NewMovieViewController()
        newMovieView.loadView()
        newMovieView.viewDidLoad()
    }
    func  test_setupViewWithData() {
        let newMovieView = NewMovieViewController()
        newMovieView.loadView()
        newMovieView.showImagePickerAlert()
    }
    func  test_checkforDataFeilds() {
        let newMovieView = NewMovieViewController()
        newMovieView.loadView()
        XCTAssertEqual(newMovieView.checkforDataFeilds(), false)
    }
    func  test_getMovieDataInputs() {
        let newMovieView = NewMovieViewController()
        newMovieView.loadView()
         XCTAssertNotNil(newMovieView.getMovieDataInputs())
    }
    func  test_showEmptyFeilds() {
        let newMovieView = NewMovieViewController()
        newMovieView.loadView()
        newMovieView.showEmptyFeilds()
    }

}
