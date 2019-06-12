//
//  DetailsPageViewController.swift
//  MovieApp
//
//  Created by Ayman Fathy on 6/12/19.
//  Copyright © 2019 Instabug Inc. All rights reserved.
//

import UIKit

class DetailsPageViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releasDateLabel: UILabel!
    @IBOutlet weak var overViewTextView: UITextView!
    
    // MARK: - Variables
    var presenter: DetailsPagePresenter!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
         presenter = DetailsPagePresenter.init(viewController: self)
    }
    
}
extension DetailsPageViewController: DetailsPageViewProtocol {
    
}
