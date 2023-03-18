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
    static let youtubeApiKey = "AIzaSyAgPKQmyCYeA7732KTYUcioIc4aqq99iIs"
    static let youtubeBaseURL = "https://youtube.googleapis.com/youtube"
}

enum APIError: Error {
    case failedToGetData
    case failedToFetchData
}

class APICaller {
    
    static let shared = APICaller()
    // Fetching Movies
    func getTrendingMovies(complition: @escaping (Result<[Title],Error>) -> Void) {
        guard let url = URL(string: "\(Constant.baseURL)/3/trending/movie/day?api_key=\(Constant.ApiKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else { return }
            // complition(.failure(APIError.failedToGetData))
            
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                complition(.success(result.results))
            } catch {
                print(APIError.failedToFetchData)
            }
        }.resume()
    }
    
    // Fetching TVs
    func getTrendingTVs(complition: @escaping (Result<[Title],Error>) -> Void)  {
        guard let url = URL(string: "\(Constant.baseURL)/3/trending/tv/day?api_key=\(Constant.ApiKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else { return }
            //complition(.failure(APIError.failedToGetData))
            
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                complition(.success(result.results))
                
            } catch {
                print(APIError.failedToFetchData)
            }
        }.resume()
    }
    
    // Fetching Upcoming Movies
    //https://api.themoviedb.org/3/movie/upcoming?api_key=<<api_key>>&language=en-US&page=1
    func getUpcomingMovies(complition: @escaping (Result<[Title],Error>) -> Void) {
        guard let url = URL(string: "\(Constant.baseURL)/3/movie/upcoming?api_key=\(Constant.ApiKey)&language=en-US&page=1") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else { return }
            //complition(.failure(APIError.failedToGetData))
            
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                complition(.success(result.results))
            } catch {
                print(APIError.failedToFetchData)
            }
        }.resume()
    }
    // Fetching Popular Movies
    //https://api.themoviedb.org/3/movie/popular?api_key=<<api_key>>&language=en-US&page=1
    func getPopulatMovies(complition: @escaping (Result<[Title],Error>) -> Void) {
        guard let url = URL(string: "\(Constant.baseURL)/3/movie/popular?api_key=\(Constant.ApiKey)&language=en-US&page=1") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else { return }
            //complition(.failure(APIError.failedToGetData))
            
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                complition(.success(result.results))
            } catch {
                print(APIError.failedToFetchData)
            }
        }.resume()
    }
    // Fetching Top Rated Movies
    //https://api.themoviedb.org/3/movie/top_rated?api_key=<<api_key>>&language=en-US&page=1
    func getTopRated(complition: @escaping (Result<[Title],Error>) -> Void) {
        
        guard let url = URL(string: "\(Constant.baseURL)/3/movie/top_rated?api_key=\(Constant.ApiKey)&language=en-US&page=1") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else { return }
            // complition(.failure(APIError.failedToGetData))
            
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                complition(.success(result.results))
            } catch {
                print(APIError.failedToFetchData)
            }
        }.resume()
    }
    // Fetch Discover Movies
    func getDiscoverMovies(complition: @escaping (Result<[Title],Error>) -> Void) {
        
        guard let url = URL(string: "\(Constant.baseURL)/3/discover/movie?api_key=\(Constant.ApiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else { return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else { return }
            // complition(.failure(APIError.failedToGetData))
            
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                complition(.success(result.results))
            } catch {
                print(APIError.failedToFetchData)
            }
        }.resume()
    }
     // fetching search query
    func search(with query: String, complition: @escaping (Result<[Title],Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constant.baseURL)/3/search/movie?api_key=\(Constant.ApiKey)&query=\(query)") else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else { return }
            // complition(.failure(APIError.failedToGetData))
            
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                complition(.success(result.results))
            } catch {
                print(APIError.failedToFetchData)
            }
        }.resume()
    }
    // getting movies from youtube API
    func getMovie(with query: String, complition: @escaping (Result<VideoElement,Error>) -> Void) {
        
        //https://youtube.googleapis.com/youtube/v3/search?key=[YOUR_API_KEY]
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constant.youtubeBaseURL)/v3/search?q=\(query)&key=\(Constant.youtubeApiKey)") else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else { return }
            // complition(.failure(APIError.failedToGetData))
            
            do {
                let result = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                complition(.success(result.items[0]))
              
            } catch {
                complition(.failure(error))
               print(error.localizedDescription)
            }
        }.resume()
    }
}



