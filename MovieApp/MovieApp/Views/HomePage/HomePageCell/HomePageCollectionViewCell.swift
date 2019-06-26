//
//  HomePageCollectionViewCell.swift
//  MovieApp
//
//  Created by Ayman Fathy on 6/12/19.
//  Copyright © 2019 Instabug Inc. All rights reserved.
//

import UIKit

class HomePageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(viewModel: ImageViewCellProtocol?) {
        posterImageView.image = UIImage(named: "placeholder")
        guard let model = viewModel else {return}
        // check if dataModel is local or not to use baseUrl for remote Image
        if viewModel?.isLocalUrl ?? false {
             let url = URL.init(fileURLWithPath: viewModel?.imageURL ?? "")
               if FileManager.default.fileExists(atPath: url.path) {
                posterImageView.image = UIImage(contentsOfFile: url.path)
            }
        } else {
             posterImageView.imageFromServerURL("https://image.tmdb.org/t/p/original" + model.imageURL, placeHolder: UIImage(named: "placeholder"))
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.cancelImageLoad()
    }

}
protocol ImageViewCellProtocol {
    var isLocalUrl: Bool { get }
    var imageURL: String { get }
}

class ImageViewCellModel: ImageViewCellProtocol {
    var imageURL: String
    var isLocalUrl: Bool
    init(imageUrl: String, isLocalUrl: Bool) {
        self.imageURL = imageUrl
        self.isLocalUrl = isLocalUrl
    }
}
