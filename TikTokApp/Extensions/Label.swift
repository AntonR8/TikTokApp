//
//  Label.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 16.10.2024.
//

import SwiftUI

extension LabelStyle where Self == IconTintLabelStyle {

    static func iconTint(_ color: Color) -> Self {
        .init(color)
    }    
}

struct IconTintLabelStyle: LabelStyle {

    init(_ color: Color) {
        self.color = color
    }

    private let color: Color

    func makeBody(
        configuration: Configuration
    ) -> some View {
        Label(
            title: { configuration.title },
            icon: { configuration.icon.foregroundStyle(color) }
        )
    }
}
