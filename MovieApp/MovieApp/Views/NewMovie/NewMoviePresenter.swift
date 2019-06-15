//
//  NewMoviePresenter.swift
//  MovieApp
//
//  Created by Ayman Fathy on 6/15/19.
//  Copyright © 2019 Instabug Inc. All rights reserved.
//

import Foundation
protocol NewMovieViewControllerProtocol: class{
    
}
class NewMoviePresenter {
    private weak var viewController: NewMovieViewControllerProtocol!
    init(viewController:NewMovieViewControllerProtocol) {
        self.viewController = viewController
    }
    func getStringDate(date:Date)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let stringDate = formatter.string(from: date)
        return stringDate
    }
}
