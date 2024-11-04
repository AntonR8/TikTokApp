//
//  ResponseModel.swift
//  DownloadTesting
//
//  Created by Антон Разгуляев on 23.10.2024.
//

import Foundation

struct DownloadLinkResponse: Codable {
    let error: Bool
    let messages: [String]
    let data: URLData
}

struct URLData: Codable {
    let url: String
}
