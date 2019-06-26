//
//  NewMoviePresenterTest.swift
//  MovieAppTests
//
//  Created by Ayman Fathy on 6/17/19.
//  Copyright © 2019 Instabug Inc. All rights reserved.
//

import XCTest
@testable import MovieApp
class NewMoviePresenterTest: XCTestCase {

    func test_saveData() {
        class NewMovieView: NewMovieViewControllerProtocol {
            func checkforDataFeilds() -> Bool {
                return true
            }

            func getMovieDataInputs() -> MoviesItem {
                let movie = MoviesItem.init(title: "title", releaseDate: "releaseDate", overview: "", posterPath: "posterPath", isLocalData: true)
                return movie
            }
        }
        let newMovieView = NewMovieView()
        let newMoviePresenter = NewMoviePresenter.init(viewController: newMovieView)
        newMoviePresenter.saveData()
    }
    func test_getStringDate() {
        class NewMovieView: NewMovieViewControllerProtocol {
        }
        let newMovieView = NewMovieView()
        let newMoviePresenter = NewMoviePresenter.init(viewController: newMovieView)
        let date = Date()
       XCTAssertEqual(newMoviePresenter.getStringDate(date: date), "2019-06-18") // current Data
    }

}
extension NewMovieViewControllerProtocol {
    func checkforDataFeilds() -> Bool {
        return true
    }

    func getMovieDataInputs() -> MoviesItem {
        let movie = MoviesItem.init(title: "title", releaseDate: "releaseDate", overview: "", posterPath: "posterPath", isLocalData: true)
        return movie
    }
    func showEmptyFeilds() {

    }

    func popViewController() {

    }
}
