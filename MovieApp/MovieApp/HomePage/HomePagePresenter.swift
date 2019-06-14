//
//  HomePagePresenter.swift
//  MovieApp
//
//  Created by Ayman Fathy on 6/11/19.
//  Copyright © 2019 Instabug Inc. All rights reserved.
//

import Foundation
protocol HomePageViewProtocol: class {
    func showLoadingIndicator()
    func showEmptyData()
    func showItemsList()
    func navigateToDetailsPage(dataModel:Result2?)
}
class HomePagePresenter{
    
    //MARK: - Variables
    private weak var homePageController: HomePageViewProtocol!
    var dataSource: HomePageModel!
    
    // MARK: - Initializers 
    init(ViewController:HomePageViewProtocol) {
        homePageController = ViewController
    }
    
    // MARK: - Functions
    func setup(){
        // TODO: get data
//        let homepageItem = HomePageItem.init(title: "title1", posterPath: "/kZv92eTc0Gg3mKxqjjDAM73z9cy.jpg", overview: "/kZv92eTc0Gg3mKxqjjDAM73z9cy.jpg", releaseDate: "/kZv92eTc0Gg3mKxqjjDAM73z9cy.jpg")
//        dataSource = HomePageModel.init(page: 1, totalResults: 20, totalPages: 20, results: [homepageItem])
        MovieServiceAPI.shared.requestData(url: Endpoint.discover.rawValue, decodingType: HomePageModel.self) { result in
            switch result {
                
            case .success(let model):
                self.dataSource = model
                self.homePageController.showItemsList()
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    func goToDetailsScreen(index:Int){
        homePageController.navigateToDetailsPage(dataModel: dataSource.results?[index])
    }
    
    
    
}

