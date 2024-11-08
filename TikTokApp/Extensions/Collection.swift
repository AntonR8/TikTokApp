//
//  Collection.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 08.11.2024.
//

import SwiftUI

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
