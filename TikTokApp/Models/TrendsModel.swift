//
//  TrendsMusicModel.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 25.10.2024.
//

import Foundation

struct TrendsResponse: Codable {
    let error: Bool
    let messages: [String]
    let data: [SectionModel]
}

struct SectionModel: Codable, Hashable, Identifiable {
    let id: Int
    let title: String
    let isMain: Bool
    let pos: Int
    let sets: [CountryChart]
}

struct CountryChart: Codable, Hashable, Identifiable {
    let id: Int
    let title: String
    let pos: Int
    let isPremium: Bool
    let image: String
    let music: [TrackModel]
}

struct TrackModel: Codable, Hashable {
    let title, creator: String
    let cover: String
    let trend: String?
    let url: String
}


