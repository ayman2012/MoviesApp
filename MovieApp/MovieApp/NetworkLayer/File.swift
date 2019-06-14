//
//  File.swift
//  MovieApp
//
//  Created by Ayman Fathy on 6/14/19.
//  Copyright © 2019 Instabug Inc. All rights reserved.
//

import Foundation
enum Endpoint: String{
    case discover = "https://api.themoviedb.org/3/discover/movie?api_key=acea91d2bff1c53e6604e4985b6989e2&page=1"
}
class MovieServiceAPI {
    
    public static let shared = MovieServiceAPI()
    private init() {}
    private let urlSession = URLSession.shared
    private let baseURL = "https://api.themoviedb.org/3"
    private let apiKey = "acea91d2bff1c53e6604e4985b6989e2"
   
    public enum Result<T> {
        case success(T)
        case failure(Error)
    }

    func requestData<T: Decodable>(url:String,decodingType: T.Type,completionHandler: @escaping (Result<T>)->()){
    let url = URL.init(string: url)
//    let session = URLSession(configuration: URLSessionConfiguration.default)
    urlSession.dataTask(with: url!) { (data, response, error) in
        do
        {
            let model : T =   try JSONDecoder().decode(decodingType.self, from: data!)
            completionHandler(Result.success(model))
        }
        catch let error
        {
            completionHandler(Result.failure(error))
        }
        }.resume()
}
}
