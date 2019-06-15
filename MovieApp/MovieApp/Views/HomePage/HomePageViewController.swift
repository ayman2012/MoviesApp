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
    @IBOutlet weak var loadingIndicatorViewHeightConstrant: NSLayoutConstraint!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBAction func tryAginAction(_ sender: UIButton) {
    }
    @IBAction func addMovieAction(_ sender: Any) {
        let newMovieViewController = NewMovieViewController()
        newMovieViewController.viewWillLayoutSubviews()
        self.navigationController?.pushViewController(newMovieViewController, animated: true)
    }
    // MARK: - Variables
    var presenter : HomePagePresenter!{
        didSet{
            presenter.getDataFromEndpoint(pageNumber:1)
        }
    }
    private var pageNumber:Int = 1
    
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
        moviesCollectionView.prefetchDataSource = self
        moviesCollectionView.register(UINib.init(nibName: "\(HomePageCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(HomePageCollectionViewCell.self)")
        moviesCollectionView.register(UINib(nibName: "SectionHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "SectionHeader")
   
    }
    
    
}
extension HomePageViewController: UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
          return  presenter.dataSource?.storedResult?.count ?? 0
        default:
          return  presenter.dataSource?.results?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HomePageCollectionViewCell.self)", for: indexPath) as? HomePageCollectionViewCell else {return UICollectionViewCell()}
        switch indexPath.section {
        case 0:
            cell.configureCell(model: presenter.dataSource?.storedResult?[indexPath.row])
        default:
            cell.configureCell(model: presenter.dataSource?.results?[indexPath.row])
        }
        return cell
    }
    // this delegte to set cell size base on device width
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (UIScreen.main.bounds.width / 2) - 20 , height: 160) // let heigth to be 160
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.goToDetailsScreen(index: indexPath)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if presenter.dataSource?.storedResult?.count ?? 0 > 0{
            return 2
        }else{
            return 1
        }
    }
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return 10
    //    }
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        return 10
    //    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionView.elementKindSectionFooter && indexPath.section == 1 {
//            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath) as! FooterView
//            let loading = UIActivityIndicatorView()
//            loading.style = .gray
//            loading.translatesAutoresizingMaskIntoConstraints = false
//            loading.tintColor = UIColor.gray
//            loading.tag = -123456
//            view.addSubview(loading)
//            view.addConstraint(NSLayoutConstraint(item: loading, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
//            view.addConstraint(NSLayoutConstraint(item: loading, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0))
//            return view
//        }
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind , withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader{
          if collectionView.numberOfSections > 1 {
                switch indexPath.section {
                case 0 :
                    sectionHeader.sectionHeaderLabel.text = "your movies"
                default:
                    sectionHeader.sectionHeaderLabel.text = "List Of Movies"
                   
                    
                }
            }else{
                sectionHeader.sectionHeaderLabel.text = "List Of Movies"
            }
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    private func getMoreData(pageNumber:Int){
       
    }
  
}
extension HomePageViewController: HomePageViewProtocol{
   
    func navigateToDetailsPage(dataModel: Result2?) {
        let detailsPageView = DetailsPageViewController()
        guard let dataModel = dataModel else {return}
        detailsPageView.presenter.setDataModel(model:dataModel)
        self.navigationController?.pushViewController(detailsPageView, animated: true)
    }
     func showLoadingIndicator(){
        loadingIndicatorViewHeightConstrant.constant = 40
        activityIndicatorView.startAnimating()
        moviesCollectionView.isScrollEnabled = false
    }
     func hideLoadingIndicator(){
        loadingIndicatorViewHeightConstrant.constant = 0
        activityIndicatorView.stopAnimating()
        moviesCollectionView.isScrollEnabled = true
        activityIndicatorView.backgroundColor = .red
        activityIndicatorView.isHidden = true
        activityIndicatorView.hidesWhenStopped = true

    }
    func showEmptyData() {
        
    }
    
    func showItemsList() {
        DispatchQueue.main.async {
            self.moviesCollectionView.reloadData()
        }
    }
}
extension HomePageViewController: UICollectionViewDataSourcePrefetching{
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            pageNumber += 1
            presenter.getDataFromEndpoint(pageNumber: pageNumber)
        }
    }
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
       let lastIndex = (presenter.dataSource.results?.count ?? 0) / 2

    return indexPath.row >= lastIndex
    }
}
