//
//  MenuElementView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 10.10.2024.
//

import SwiftUI

struct SettingsElementLabel: View {
    let image: String
    let title: String
    let showChevron: Bool
    let description: String

    init(image: String, title: String, showChevron: Bool = false, description: String = "") {
        self.image = image
        self.title = title
        self.showChevron = showChevron
        self.description = description
    }

    var body: some View {
        HStack(alignment: .bottom) {
            Image(systemName: image)
                .foregroundStyle(.accent)
                .font(.title3)
                .frame(width: 25)
            Text(title)
                .padding(.horizontal, 8)
                .lineLimit(1)
            Spacer()
            Text(description)
            if !showChevron {
                Image(systemName: "chevron.right")
                    .foregroundStyle(.tertiary)
            }
        }
    }
}

#Preview {
    SettingsElementLabel(image: "star.bubble", title: "Rate our app")
}


