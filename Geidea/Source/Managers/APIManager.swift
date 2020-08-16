//
//  APIManager.swift
//  Geidea
//
//  Created by Bharat Shankar on 15/08/20.
//  Copyright © 2020 geidea. All rights reserved.
//

import Foundation

struct APIManager {
    
    static var shared: APIManager = APIManager()
    
    private let domain: String = "https://rss.itunes.apple.com/api/v1"
    
    typealias CompletionHandler<T> = (Result<T, Error>) -> Void
    
    enum APIError: Error {
        case somethingWentWrong
        
        var localizedDescription: String {
            switch self {
            case .somethingWentWrong:
                return "Something went wrong!!!"
            }
        }
    }
    
    func fetchApps(_ completionHandler: @escaping CompletionHandler<[ModelApp]>) {
        
        let url: URL = URL.init(string: domain + "/sa/ios-apps/top-free/all/100/explicit.json")!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            DispatchQueue.main.async {
                
                if let error = error {
                    completionHandler(.failure(error))
                    
                } else if let data = data {
                    
                    do {
                        let mainJSON = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                        
                        if let mainJSONDict = mainJSON as? [String: Any],
                            let feed: [String: Any] = mainJSONDict["feed"] as? [String: Any],
                            let results: [[String: Any]] = feed["results"] as? [[String: Any]],
                            let resultsData: Data = try? JSONSerialization.data(withJSONObject: results, options: .fragmentsAllowed) {
                            
                            
                            let apps: [ModelApp] = try JSONDecoder.init().decode([ModelApp].self, from: resultsData)
                            
                            completionHandler(.success(apps))
                        } else {
                            
                            completionHandler(.failure(APIError.somethingWentWrong))
                        }
                        
                    } catch {
                        completionHandler(.failure(error))
                    }
                }
            }
        })
        
        task.resume()
    }
}
