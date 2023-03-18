//
//  YoutubeSearchResults.swift
//  Netflix Clone
//
//  Created by Vladlens Kukjans on 15/03/2023.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
    
}

struct IdVideoElement: Codable {
    let  kind: String
  let videoId: String
    
}
