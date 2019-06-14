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
        title = "Movies"
    }
    
    func setupMoviesCollectionView(){
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        moviesCollectionView.register(UINib.init(nibName: "\(HomePageCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(HomePageCollectionViewCell.self)")
    }
    
    
}
extension HomePageViewController: UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.dataSource?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HomePageCollectionViewCell.self)", for: indexPath) as? HomePageCollectionViewCell else {return UICollectionViewCell()}
        cell.configureCell(model: presenter.dataSource?.results?[indexPath.row])
        return cell
    }
    // this delegte to set cell size base on device width
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (UIScreen.main.bounds.width / 2) - 20 , height: 160) // let heigth to be 160
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.goToDetailsScreen(index: indexPath.row)
    }
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return 10
    //    }
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        return 10
    //    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind , withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader{
            sectionHeader.sectionHeaderLabel.text = "list of movies"
            return sectionHeader
        }
        return UICollectionReusableView()
    }
}
extension HomePageViewController: HomePageViewProtocol{
    func navigateToDetailsPage(dataModel: Result2?) {
        let detailsPageView = DetailsPageViewController()
        guard let dataModel = dataModel else {return}
        detailsPageView.presenter.setDataModel(model:dataModel)
        self.navigationController?.pushViewController(detailsPageView, animated: true)
    }
    
    func showLoadingIndicator() {
        
    }
    
    func showEmptyData() {
        
    }
    
    func showItemsList() {
        DispatchQueue.main.async {
            self.moviesCollectionView.reloadData()
        }
    }
}
