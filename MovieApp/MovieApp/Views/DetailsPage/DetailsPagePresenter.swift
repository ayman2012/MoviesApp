//
//  DetailsPagePresenter.swift
//  MovieApp
//
//  Created by Ayman Fathy on 6/12/19.
//  Copyright © 2019 Instabug Inc. All rights reserved.
//

import Foundation
protocol DetailsPageViewProtocol: class {
    func setupViewWithData(model: MoviesItem?)
}
class DetailsPagePresenter {

    private weak var detailsPageView: DetailsPageViewProtocol!
    private var dataSource: MoviesItem?

    init(viewController: DetailsPageViewProtocol) {
        detailsPageView = viewController
    }
    func setDataModel(model: MoviesItem) {
        self.dataSource = model
    }
    func setup() {
        detailsPageView.setupViewWithData(model: dataSource)
    }
}
