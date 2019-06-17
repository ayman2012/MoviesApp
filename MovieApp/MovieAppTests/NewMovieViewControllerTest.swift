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
    
    func  test_setupViewController(){
        let newMovieView = NewMovieViewController()
        newMovieView.loadView()
        newMovieView.viewDidLoad()
    }
    func  test_setupViewWithData(){
        let newMovieView = NewMovieViewController()
        newMovieView.loadView()
        let movie = MoviesItem.init(title: "title", releaseDate: "releaseDate", overview: "", posterPath: "posterPath", isLocalData: true)
        newMovieView.showImagePickerAlert()
    }
    func  test_checkforDataFeilds(){
        let newMovieView = NewMovieViewController()
        newMovieView.loadView()
        let movie = MoviesItem.init(title: "title", releaseDate: "releaseDate", overview: "", posterPath: "posterPath", isLocalData: true)
        newMovieView.checkforDataFeilds()
    }
    func  test_getMovieDataInputs(){
        let newMovieView = NewMovieViewController()
        newMovieView.loadView()
        let movie = MoviesItem.init(title: "title", releaseDate: "releaseDate", overview: "", posterPath: "posterPath", isLocalData: true)
        newMovieView.getMovieDataInputs()
    }
    func  test_showEmptyFeilds(){
        let newMovieView = NewMovieViewController()
        newMovieView.loadView()
        let movie = MoviesItem.init(title: "title", releaseDate: "releaseDate", overview: "", posterPath: "posterPath", isLocalData: true)
        newMovieView.showEmptyFeilds()
    }
    
    
}
