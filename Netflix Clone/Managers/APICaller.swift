//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Vladlens Kukjans on 14/03/2023.
//

import Foundation

struct Constant {
    
  static let ApiKey = "28dff7200fd5e5a0ceb7e394627b1a11"
  static let baseURL = "https://api.themoviedb.org/"
    
}

enum APIError: Error {
    case failedToGetData
    case failedToFetchData
}

class APICaller {
    
    static let shared = APICaller()
        // Fetching Movies
    func getTrendingMovies(complition: @escaping (Result<[Movie],Error>) -> Void) {
        guard let url = URL(string: "\(Constant.baseURL)/3/trending/movie/day?api_key=\(Constant.ApiKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else { return }
            complition(.failure(APIError.failedToGetData))
            
            do {
                let result = try JSONDecoder().decode(TendingMoviesResponse.self, from: data)
                complition(.success(result.results))
            } catch {
                print(APIError.failedToFetchData)
            }
        }.resume()
    }
    
        // Fetching TVs
    func getTrendingTVs(complition: @escaping (Result<[TV],Error>) -> Void)  {
        guard let url = URL(string: "\(Constant.baseURL)/3/trending/tv/day?api_key=\(Constant.ApiKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else { return }
            complition(.failure(APIError.failedToGetData))
            
            do {
                let result = try JSONDecoder().decode(TrendingTvResponse.self, from: data)
                print(result)
                
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}



