//
//  SettingsElementView.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 15.10.2024.
//

import SwiftUI

struct SettingsButton: View {
    let image: String
    let title: String
    let showChevron: Bool? = nil
    let action: () -> Void
    let description: String?

    var body: some View {
        Button(action: action) {
            SettingsElementLabel(image: image, title: title, showChevron: showChevron ?? false, description: description ?? "")
        }

    }
}

#Preview {
    SettingsButton(image: "star.bubble", title: "Rate our app", action: {}, description: nil)
}
