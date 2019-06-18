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
    func hideLoadingIndicator()
    func showNotFoundData()
    func updataViewControllerWithData()
    func navigateToDetailsPage(dataModel:MoviesItem?)
}
class HomePagePresenter{
    
    //MARK: - Variables
    private weak var homePageController: HomePageViewProtocol!
    var dataSource: HomePageModel!
    
    // MARK: - Initializers 
    init(viewController:HomePageViewProtocol) {
        homePageController = viewController
    }
    
    // MARK: - Functions
    func getDataFromEndpoint(pageNumber:Int){
        // TODO: get data
        homePageController.showLoadingIndicator()
        NetworkManager.shared.requestData(url: Endpoint.discover.rawValue, pageNumber: pageNumber, decodingType: HomePageModel.self) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let model):
                // check if no data found then create new dataItems else append the new dataItems
                if self.dataSource?.results?.isEmpty ?? true{
                    self.dataSource = model
                }else{
                    self.dataSource.results? += model.results!
                }
                self.homePageController.updataViewControllerWithData()
            case .failure(_):
                // if error check if no data found to display then show not found data view
                if self.dataSource?.storedResult?.isEmpty ?? true && self.dataSource?.results?.isEmpty ?? true {
                    self.homePageController.showNotFoundData()
                }
            }
            self.homePageController.hideLoadingIndicator()
        }
    }
    func goToDetailsScreen(index:IndexPath){
        if dataSource.storedResult?.count ?? 0 > 0{
            switch index.section {
            case 0:
                homePageController.navigateToDetailsPage(dataModel: dataSource.storedResult?[index.row])
            default:
                homePageController.navigateToDetailsPage(dataModel: dataSource.results?[index.row])
            }
        }else{
            homePageController.navigateToDetailsPage(dataModel: dataSource.results?[index.row])
        }
       
    }
    func getLoacalData(){
       let movies = CoreDataManager.shared.getMovies()
        if dataSource != nil {
            dataSource.storedResult = movies
        }
        else{
            self.dataSource = HomePageModel(results: [], storedResult: movies)
        }
        homePageController.updataViewControllerWithData()
    } 
}

