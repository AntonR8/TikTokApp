//
//  CapsuleEmptyButton.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 16.10.2024.
//

import SwiftUI

struct CapsuleEmptyButton: View {
    var leftIcon: String?
    var title: String?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                if let leftIcon {
                    Image(systemName: leftIcon)
                }
                if let title {
                    Text(title)
                }
            }
            .foregroundStyle(.accent)
            .padding(14)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(.accent, lineWidth: 1)
                    .foregroundStyle(.clear)
            )
            .padding(1)
        }
    }
}

#Preview {
    CapsuleEmptyButton(leftIcon: "plus", title: "sdfsdfdsf", action: {})
}
