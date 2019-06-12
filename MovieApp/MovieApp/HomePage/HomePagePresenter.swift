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
}
class HomePagePresenter{
    
    //MARK: - Variables
    private weak var controller: HomePageViewProtocol!
    var dataSource: [DataModel]!
    
    // MARK: - Initializers 
    init(ViewController:HomePageViewProtocol) {
        controller = ViewController
    }
    
    // MARK: - Functions
    func setup(){
        // TODO: get data
        dataSource = [DataModel(),DataModel(),DataModel(),DataModel(),DataModel()]
    }
    
    
    
    
}
class DataModel{
    
}
