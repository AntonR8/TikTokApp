//
//  SettingsShareLink.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 16.10.2024.
//

import SwiftUI

struct SettingsShareLink: View {
    let shareLink: URL
    let image: String
    let title: String

    var body: some View {
        ShareLink(item: shareLink) {
            SettingsElementLabel(image: image, title: title)
        }
    }
}

#Preview {
    SettingsShareLink(shareLink: URL(string:"")!, image: "square.and.arrow.up", title: "Share with friends")
}
