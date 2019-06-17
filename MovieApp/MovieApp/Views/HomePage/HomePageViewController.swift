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
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBAction func tryAginAction(_ sender: UIButton) {
        presenter.getDataFromEndpoint(pageNumber:pageNumber)
    }
    @IBAction func addMovieAction(_ sender: Any) {
        let newMovieViewController = NewMovieViewController()
        self.navigationController?.pushViewController(newMovieViewController, animated: true)
    }
    // MARK: - Variables
    var presenter : HomePagePresenter!{
        didSet{
            presenter.getLoacalData()
            presenter.getDataFromEndpoint(pageNumber:pageNumber)
        }
    }
    private var pageNumber:Int = 1
    private var isLoading: Bool = false

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMoviesCollectionView()
        presenter = HomePagePresenter.init(viewController: self)
        title = "Movies"
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter.getLoacalData()
    }
    func setupMoviesCollectionView(){
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        moviesCollectionView.register(UINib.init(nibName: "\(HomePageCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(HomePageCollectionViewCell.self)")
        moviesCollectionView.register(UINib(nibName: "SectionHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "SectionHeader")
    }
}
extension HomePageViewController: UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if presenter.dataSource?.storedResult?.count ?? 0 == 0 {
            return presenter.dataSource?.results?.count ?? 0
        }else{
            switch section {
            case 0:
                return  presenter.dataSource?.storedResult?.count ?? 0
            default:
                return  presenter.dataSource?.results?.count ?? 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HomePageCollectionViewCell.self)", for: indexPath) as? HomePageCollectionViewCell else {return UICollectionViewCell()}
        if presenter.dataSource?.storedResult?.count ?? 0 == 0 {
            cell.configureCell(model: presenter.dataSource?.results?[indexPath.row])
        }else{
            switch indexPath.section {
            case 0:
                cell.configureCell(model: presenter.dataSource?.storedResult?[indexPath.row])
            default:
                cell.configureCell(model: presenter.dataSource?.results?[indexPath.row])
            }
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
        if presenter.dataSource?.storedResult?.count ?? 0 > 0 && presenter.dataSource?.results?.count ?? 0 > 0 {
            return 2
        }else{
            return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind , withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader{
            if presenter.dataSource?.storedResult?.count ?? 0 == 0 {
                sectionHeader.sectionHeaderLabel.text = "All Movies"
                return sectionHeader
            }else{
                switch indexPath.section {
                case 0 :
                    sectionHeader.sectionHeaderLabel.text = "My Movies"
                default:
                    sectionHeader.sectionHeaderLabel.text = "All Movies"
                }
            }
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
}
extension HomePageViewController: HomePageViewProtocol{
    
    func navigateToDetailsPage(dataModel: MoviesItem?) {
        let detailsPageView = DetailsPageViewController()
        guard let dataModel = dataModel else {return}
        detailsPageView.presenter.setDataModel(model:dataModel)
        self.navigationController?.pushViewController(detailsPageView, animated: true)
    }
    func showLoadingIndicator(){
        loadingIndicatorViewHeightConstrant.constant = 60
        activityIndicatorView.startAnimating()
        moviesCollectionView.isScrollEnabled = false
    }
    func hideLoadingIndicator(){
        loadingIndicatorViewHeightConstrant.constant = 0
        activityIndicatorView.stopAnimating()
        moviesCollectionView.isScrollEnabled = true
        activityIndicatorView.isHidden = true
        activityIndicatorView.hidesWhenStopped = true
    }
    func showNotFoundData() {
        containerView.isHidden = true
        errorView.isHidden = false
    }
    func hideNotFoundData(){
        containerView.isHidden = false
        errorView.isHidden = true
    }
    func updataViewControllerWithData() {
        hideNotFoundData()
        self.moviesCollectionView.reloadData()
    }
}
extension HomePageViewController:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            pageNumber += 1
            presenter.getDataFromEndpoint(pageNumber: pageNumber)
        }
    }
}
