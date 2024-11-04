//
//  ClipInfoModel.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 22.10.2024.
//

import Foundation

struct ClipInfoResponse: Codable {
    let error: Bool
    let messages: [String]
    let data: ClipInfoModel
}

struct ClipInfoModel: Codable, Hashable {
        let username, name: String
        let avatar: String
        let videoPreview: String
        let description, musicTitle: String
        let musicUrl: String
}





