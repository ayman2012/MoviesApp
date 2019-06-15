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
    func getDataFromEndpoint(pageNumber:Int){
        // TODO: get data
        homePageController.showLoadingIndicator()
        MovieServiceAPI.shared.requestData(url: Endpoint.discover.rawValue, pageNumber: pageNumber, decodingType: HomePageModel.self) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(var model):
                if self.dataSource?.results?.isEmpty ?? true{
                    model.storedResult = self.getLocalMovies()
                    self.dataSource = model
                }else{
                    self.dataSource.results? += model.results!
                }
                self.homePageController.showItemsList()

            case .failure(let error):
                debugPrint(error)
            }
            self.homePageController.hideLoadingIndicator()
        }
    }
    func goToDetailsScreen(index:IndexPath){
        switch index.section {
        case 0:
             homePageController.navigateToDetailsPage(dataModel: dataSource.storedResult?[index.row])
        default:
             homePageController.navigateToDetailsPage(dataModel: dataSource.results?[index.row])
        }
    }
    func getLocalMovies()-> [Result2]?{
        var homePageItems: [Result2] = []
        let path = Bundle.main.path(forResource: "Movies", ofType: "plist")!
        let dict = NSDictionary(contentsOfFile: path)
        if let fileUrl = Bundle.main.url(forResource: "Movies", withExtension: "plist"),
            let data = try? Data(contentsOf: fileUrl) {
            if let result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [[String: Any]] { // [String: Any] which ever it is
                let decoder = PropertyListDecoder()
                do{
                    homePageItems = try decoder.decode([Result2].self, from: data)
                }
                catch{
                    print(error)
                }
            }
        }
        return homePageItems
    }
    
    
    
}

