//
//  SmallImageLink.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 21.10.2024.
//

import SwiftUI

struct SmallImageLink: View {
        var leftIcon: String?
        var title: String?
        var rightIcon: String?
        var foregroundStyle: Color
        var backGroundStyle: Color = .gray.opacity(0.5)
        var borderColor: Color?
        let destination: AnyView

        var body: some View {
            NavigationLink {
                destination
            } label: {
                HStack {
                    if let leftIcon {
                        Image(systemName: leftIcon)
                    }

                    if let title {
                        Text(title)
                            .padding(.horizontal, 8)
                    }

                    if let rightIcon {
                        Image(systemName: rightIcon)
                    }
                }
                .foregroundStyle(foregroundStyle)
                .padding(8)
                .background(
                    Capsule()
                        .fill(backGroundStyle)
                        .stroke(borderColor ?? .clear, lineWidth: 1)
                )
            }
            .padding(1)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        SmallImageLink(title: "Restore", foregroundStyle: .white, destination: AnyView(TrendsView()))
    }
}
