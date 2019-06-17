//
//  DetailsPagePresenter.swift
//  MovieApp
//
//  Created by Ayman Fathy on 6/12/19.
//  Copyright © 2019 Instabug Inc. All rights reserved.
//

import Foundation
protocol DetailsPageViewProtocol: class {
    func setupViewWithData(model:MoviesItems)
}
class DetailsPagePresenter{
    
    private weak var DetailsPageView: DetailsPageViewProtocol!
    var dataSource: MoviesItems!

    init(viewController:DetailsPageViewProtocol) {
        DetailsPageView = viewController
    }
    func setDataModel(model:MoviesItems){
        self.dataSource = model
    }
    func setup(){
        DetailsPageView.setupViewWithData(model: dataSource)
    }
}
