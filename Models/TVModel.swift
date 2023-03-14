//
//  TVModel.swift
//  Netflix Clone
//
//  Created by Vladlens Kukjans on 14/03/2023.
//

import Foundation

struct TrendingTvResponse: Codable {
    let results: [TV]
}

struct TV: Codable {
    let id : Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_avarege: Double?
    let first_air_date: String?
    let origin_country: [String]?
    let original_language: String?
    let popularity: Double?
}
