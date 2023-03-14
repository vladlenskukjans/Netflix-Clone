//
//  TitleModel.swift
//  Netflix Clone
//
//  Created by Vladlens Kukjans on 14/03/2023.
//

import Foundation


struct TendingTitleResponse: Codable {
    let results: [Title]
    
}

struct Title: Codable {
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

/*
 {
adult = 0;
"backdrop_path" = "/uDgy6hyPd82kOHh6I95FLtLnj6p.jpg";
"first_air_date" = "2023-01-15";
"genre_ids" =             (
 18
);
id = 100088;
"media_type" = tv;
name = "The Last of Us";
"origin_country" =             (
 US
);
"original_language" = en;
"original_name" = "The Last of Us";
overview = "Twenty years after modern civilization has been destroyed, Joel, a hardened survivor, is hired to smuggle Ellie, a 14-year-old girl, out of an oppressive quarantine zone. What starts as a small job soon becomes a brutal, heartbreaking journey, as they both must traverse the United States and depend on each other for survival.";
popularity = "6400.827";
"poster_path" = "/uKvVjHNqB5VmOrdxqAt2F7J78ED.jpg";
"vote_average" = "8.808999999999999";
"vote_count" = 2596
 
 
 */
