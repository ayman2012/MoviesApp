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
    func configureCell(model:Result2?){
        posterImageView.imageFromServerURL("https://image.tmdb.org/t/p/original" + (model?.posterPath)! ?? "", placeHolder: nil)
    }

}
