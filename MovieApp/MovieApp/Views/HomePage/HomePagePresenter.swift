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
    func navigateToDetailsPage(dataModel: MoviesItem?)
}
class HomePagePresenter {

    // MARK: - Variables
    private weak var homePageController: HomePageViewProtocol!
    private var pageNumber: Int = 0
    var dataSource: HomePageModel!

    // MARK: - Initializers 
    init(viewController: HomePageViewProtocol) {
        homePageController = viewController
    }

    // MARK: - Functions
    func getDataFromEndpoint() {
        // TODO: get data
        pageNumber += 1
        homePageController.showLoadingIndicator()
        NetworkManager.shared.requestData(url: Endpoint.discover.rawValue, pageNumber: pageNumber, decodingType: HomePageModel.self) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let model):
                if let result = model.results {
                    self.dataSource.results?.append(contentsOf: result)
                    self.homePageController.updataViewControllerWithData()
                }
            case .failure:
                // if error check if no data found to display then show not found data view
                if self.dataSource?.storedResult?.isEmpty ?? true && self.dataSource?.results?.isEmpty ?? true {
                    self.homePageController.showNotFoundData()
                }
            }
            self.homePageController.hideLoadingIndicator()
        }
    }
    func getCollectionViewMoviesItemsInSections(section: Int) -> Int {
        if dataSource?.storedResult?.count ?? 0 == 0 {
            return dataSource?.results?.count ?? 0
        } else {
            switch section {
            case 0:
                return  dataSource?.storedResult?.count ?? 0
            default:
                return  dataSource?.results?.count ?? 0
            }
        }
    }
    func getSectionTitle(section: Int) -> String {
        if dataSource?.storedResult?.count ?? 0 == 0 {
            return "All Movies"
        } else {
            switch section {
            case 0 :
               return "My Movies"
            default:
                return "All Movies"
            }
        }
    }
    func getNumberOfItemsInsection() -> Int {
        if dataSource?.storedResult?.count ?? 0 > 0 && dataSource?.results?.count ?? 0 > 0 {
            return 2
        } else {
            return 1
        }
    }
    func getUIModelForCollectionViewCell(indexPath: IndexPath) -> ImageViewCellProtocol {
        let viewModel: ImageViewCellProtocol
        if dataSource?.storedResult?.count ?? 0 == 0 {
            let imageURL = dataSource.results?[indexPath.row].posterPath
            viewModel = ImageViewCellModel.init(imageUrl: imageURL ?? "", isLocalUrl: false)
        } else {
            switch indexPath.section {
            case 0:
                let imageURL = dataSource.storedResult?[indexPath.row].posterPath
                viewModel = ImageViewCellModel.init(imageUrl: imageURL ?? "", isLocalUrl: false)
            default:
                let imageURL = dataSource.results?[indexPath.row].posterPath
                viewModel = ImageViewCellModel.init(imageUrl: imageURL ?? "", isLocalUrl: false)
            }
        }
        return viewModel
    }
    func goToDetailsScreen(index: IndexPath) {
        if dataSource.storedResult?.count ?? 0 > 0 {
            switch index.section {
            case 0:
                homePageController.navigateToDetailsPage(dataModel: dataSource.storedResult?[index.row])
            default:
                homePageController.navigateToDetailsPage(dataModel: dataSource.results?[index.row])
            }
        } else {
            homePageController.navigateToDetailsPage(dataModel: dataSource.results?[index.row])
        }

    }
    func getMoviesWithRetryAction() {
        pageNumber = 0
        getDataFromEndpoint()
    }
   private func getLoacalData() {
       let movies = CoreDataManager.shared.getMovies()
        if dataSource != nil {
            dataSource.storedResult = movies
        } else {
            self.dataSource = HomePageModel(results: [], storedResult: movies)
        }
        homePageController.updataViewControllerWithData()
    }
    func getMovies() {
        getLoacalData()
        getDataFromEndpoint()
    }
}
