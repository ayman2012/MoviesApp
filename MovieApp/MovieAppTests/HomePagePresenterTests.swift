//
//  MovieAppTests.swift
//  MovieAppTests
//
//  Created by Ayman Fathy on 6/11/19.
//  Copyright © 2019 Instabug Inc. All rights reserved.
//

import XCTest
@testable import MovieApp

class HomePagePresenterTests: XCTestCase {
  
    
    func testGoTODetailsScreen() {
        class HomePageView: HomePageViewProtocol{
            func navigateToDetailsPage(dataModel: MoviesItem?) {
                XCTAssert(true)
            }
        }
        let homePageView = HomePageView()
        let homePagePresenter = HomePagePresenter.init(viewController: homePageView)
        let movie = MoviesItem.init(title: "title", releaseDate: "releaseDate", overview: "", posterPath: "posterPath", isLocalData: true)
        homePagePresenter.dataSource = HomePageModel.init(results: [], storedResult:[movie])
        homePagePresenter.goToDetailsScreen(index: IndexPath.init(item: 0, section: 0))
    }
    
    func testGetLoacalData() {
        class HomePageView: HomePageViewProtocol{
            func updataViewControllerWithData() {
                XCTAssert(true)
            }
        }
        let homePageView = HomePageView()
        let homePagePresenter = HomePagePresenter.init(viewController: homePageView)
        let movie = MoviesItem.init(title: "title", releaseDate: "releaseDate", overview: "", posterPath: "posterPath", isLocalData: true)
        homePagePresenter.dataSource = HomePageModel.init(results: [], storedResult:[movie])
        homePagePresenter.getLoacalData()
    }
    func testGetDataFromEndpoint() {
        class HomePageView: HomePageViewProtocol{
            var expext : XCTestExpectation!
            func updataViewControllerWithData() {
                XCTAssertTrue(true)
                expext.fulfill()
            }
        }
        let homePageView = HomePageView()
        let homePagePresenter = HomePagePresenter.init(viewController: homePageView)
        let movie = MoviesItem.init(title: "title", releaseDate: "releaseDate", overview: "", posterPath: "posterPath", isLocalData: true)
        homePagePresenter.dataSource = HomePageModel.init(results: [], storedResult:[movie])
        
        homePagePresenter.getDataFromEndpoint(pageNumber: 1)
    }

    
}

fileprivate extension HomePageViewProtocol {
    func showLoadingIndicator() {
        
    }
    func hideLoadingIndicator() {
        
    }
    
    func showNotFoundData() {
        
    }
    
    func updataViewControllerWithData() {
        
    }
    
    func navigateToDetailsPage(dataModel: MoviesItem?) {
        
    }
}
