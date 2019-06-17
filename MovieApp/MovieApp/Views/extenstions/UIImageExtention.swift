//
//  UIImageExtention.swift
//  MovieApp
//
//  Created by Ayman Fathy on 6/15/19.
//  Copyright © 2019 Instabug Inc. All rights reserved.
//

import Foundation
import UIKit
let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    
    func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {
        
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            return
        }
        
        if let url = URL(string: URLString) {
//            showSpinner(onView: self)
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
//            self.removeSpinner()

        }
    }
//    func showSpinner(onView : UIView) {
//        let spinnerView = UIView.init(frame: onView.bounds)
//        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
//        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
//        ai.startAnimating()
//        ai.center = onView.center
//
//        DispatchQueue.main.async {
//            spinnerView.addSubview(ai)
//            onView.addSubview(spinnerView)
//        }
//            }
//
//    func removeSpinner() {
//        DispatchQueue.main.async {
//            self.removeFromSuperview()
//        }
//    }
}
