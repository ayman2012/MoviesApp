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
    @IBOutlet weak var overViewTextView: UILabel!

    // MARK: - Variables
    var presenter: DetailsPagePresenter!

    // MARK: - Initializer 
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        presenter = DetailsPagePresenter.init(viewController: self) // inject viewController
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        presenter = DetailsPagePresenter.init(viewController: self) // inject viewController
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setup() // notify presenter view is loaded
    }
}
extension DetailsPageViewController: DetailsPageViewProtocol {
    func setupViewWithData(model: MoviesItem?) {
        guard let model = model else {return}
        titleLabel.text = model.title
        releasDateLabel.text = model.releaseDate
        overViewTextView.text = model.overview
        if model.isLocalData ?? false {
            if FileManager.default.fileExists(atPath: (URL.init(string: model.posterPath ?? "")?.path)!) {
                posterImageView.image = UIImage(contentsOfFile: (URL.init(string: model.posterPath ?? "")?.path)!)
            }
        } else {
            let placeholderImage = UIImage.init(named: "placeholder")
            let posterBaseUrl = "https://image.tmdb.org/t/p/original"
            posterImageView.imageFromServerURL("\(posterBaseUrl)" + model.posterPath!, placeHolder: placeholderImage)
        }
    }
}
