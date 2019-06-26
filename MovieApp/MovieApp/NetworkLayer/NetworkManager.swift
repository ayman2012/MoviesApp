//
//  File.swift
//  MovieApp
//
//  Created by Ayman Fathy on 6/14/19.
//  Copyright © 2019 Instabug Inc. All rights reserved.
//

import Foundation
enum Endpoint: String {
    case discover = "/discover"
}
class NetworkManager {

    public static let shared = NetworkManager()
    private init() {}
    private let urlSession = URLSession.shared
    private let baseURL = "https://api.themoviedb.org/3"
    private let apiKey = "acea91d2bff1c53e6604e4985b6989e2"

    public enum Result<T> {
        case success(T)
        case failure(Error)
    }

    func requestData<T: Decodable>(url: String, pageNumber: Int, decodingType: T.Type,
                                   completionHandler: @escaping (Result<T>) -> Void) {
        let adsoluteURL = "\(url)/movie?api_key=\(apiKey)&page=\(pageNumber)"
        let url = URL.init(string: "\(baseURL)\(adsoluteURL)")
        urlSession.dataTask(with: url!) { (data, _, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(Result.failure(error))
                }
            } else {
                do {
                    let model: T =   try JSONDecoder().decode(decodingType.self, from: data!)
                    DispatchQueue.main.async {
                        completionHandler(Result.success(model))
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        completionHandler(Result.failure(error))
                    }
                }
            }
            }.resume()
    }
}
