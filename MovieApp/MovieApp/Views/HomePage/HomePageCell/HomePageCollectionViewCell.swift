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
    func configureCell(model:MoviesItems?){
        guard let model = model else {return}
        // check if dataModel is local or not to use baseUrl for remote Image
        if model.isLocalData ?? false{
            if FileManager.default.fileExists(atPath: (URL.init(string:model.posterPath ?? "")?.path)!) {
                posterImageView.image = UIImage(contentsOfFile: (URL.init(string:model.posterPath ?? "")?.path)!)
            }
        }else{
             posterImageView.imageFromServerURL("https://image.tmdb.org/t/p/original" + model.posterPath! , placeHolder: UIImage.init(named: "placeholder"))
        }
    }

}
