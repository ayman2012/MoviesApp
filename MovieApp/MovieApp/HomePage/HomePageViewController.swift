//
//  ViewController.swift
//  MovieApp
//
//  Created by Ayman Fathy on 6/11/19.
//  Copyright © 2019 Instabug Inc. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var errorView: UIView!
    @IBAction func tryAginAction(_ sender: UIButton) {
    }
    
    // MARK: - Variables
    var presenter : HomePagePresenter!{
        didSet{
            presenter.setup()
        }
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMoviesCollectionView()
      presenter = HomePagePresenter.init(ViewController: self)
    }
    
    func setupMoviesCollectionView(){
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        moviesCollectionView.register(UINib.init(nibName: "\(HomePageCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(HomePageCollectionViewCell.self)")
    }


}
extension HomePageViewController: UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.dataSource?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HomePageCollectionViewCell.self)", for: indexPath) as? HomePageCollectionViewCell else {return UICollectionViewCell()}
        return cell
    }
    // this delegte to set cell size base on device width
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (UIScreen.main.bounds.width / 2) - 20 , height: 160) // let heigth to be 160
    }
}
extension HomePageViewController: HomePageViewProtocol{
    func showLoadingIndicator() {
        
    }
    
    func showEmptyData() {
        
    }
    
    func showItemsList() {
        
    }
}
