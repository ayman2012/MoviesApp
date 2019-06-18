//
//  DetailsPagePresenterTests.swift
//  MovieAppTests
//
//  Created by Ayman Fathy on 6/17/19.
//  Copyright © 2019 Instabug Inc. All rights reserved.
//

import XCTest
@testable import MovieApp
class DetailsPagePresenterTests: XCTestCase {
    func test_sucessSetupDetailsScreen() {
        class DetailsPageView: DetailsPageViewProtocol{
            func setupViewWithData(model: MoviesItem?) {
                XCTAssertNotNil(model)
            }
        }
        let detailsPageView = DetailsPageView()
        let datailsPagePresenter = DetailsPagePresenter.init(viewController: detailsPageView)
        let movie = MoviesItem.init(title: "title", releaseDate: "releaseDate", overview: "", posterPath: "posterPath", isLocalData: true)
        datailsPagePresenter.setDataModel(model:movie)
        datailsPagePresenter.setup()
    }
    func test_errorSetupDetailsScreen() {
        class DetailsPageView: DetailsPageViewProtocol{
            func setupViewWithData(model: MoviesItem?) {
                XCTAssertNil(model)
            }
        }
        let detailsPageView = DetailsPageView()
        let datailsPagePresenter = DetailsPagePresenter.init(viewController: detailsPageView)
        datailsPagePresenter.setup()
    }
    
    func test_goTODetailsScreen() {
        class DetailsPageView: DetailsPageViewProtocol{
            
        }
        let detailsPageView = DetailsPageView()
        let datailsPagePresenter = DetailsPagePresenter.init(viewController: detailsPageView)
        let movie = MoviesItem.init(title: "title", releaseDate: "releaseDate", overview: "", posterPath: "posterPath", isLocalData: true)
        datailsPagePresenter.setDataModel(model:movie)
    }
}
extension DetailsPageViewProtocol{
    func setupViewWithData(model: MoviesItem?) {
        
    }
}
