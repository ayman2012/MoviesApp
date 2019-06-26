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

private let tasks: NSMapTable<UIImageView, URLSessionTask> = .weakToWeakObjects()

extension UIImageView {

    func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            return
        }

        if let url = URL(string: URLString) {
//            showSpinner(onView: self)
            self.image = placeHolder
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
                if error != nil {
                    if let urlError = error as? URLError, urlError.code == URLError.Code.cancelled { return }
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
            })
            tasks.setObject(task, forKey: self)
            task.resume()
        }
    }

    func cancelImageLoad() {
        if let task = tasks.object(forKey: self) {
            tasks.removeObject(forKey: self)
            task.cancel()
        }
    }
}
