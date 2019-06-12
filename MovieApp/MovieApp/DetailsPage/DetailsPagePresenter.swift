//
//  DetailsPagePresenter.swift
//  MovieApp
//
//  Created by Ayman Fathy on 6/12/19.
//  Copyright © 2019 Instabug Inc. All rights reserved.
//

import Foundation
protocol DetailsPageViewProtocol: class {
    
}
class DetailsPagePresenter{
    private weak var DetailsPageView: DetailsPageViewProtocol!
    init(viewController:DetailsPageViewProtocol) {
        DetailsPageView = viewController
    }
    func setup(){
        
    }
}
