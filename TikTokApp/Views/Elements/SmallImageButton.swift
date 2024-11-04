//
//  SmallImageButtons.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 13.09.2024.
//

import SwiftUI

struct SmallImageButton: View {
    var leftIcon: String?
    var title: String?
    var rightIcon: String?
    var foregroundStyle: Color
    var backGroundStyle: Color = .gray.opacity(0.5)
    var borderColor: Color?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
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
        SmallImageButton(title: "Restore", foregroundStyle: .white, action: {})
    }
}
