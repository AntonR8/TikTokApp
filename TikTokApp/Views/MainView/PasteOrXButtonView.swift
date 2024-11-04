//
//  PasteOrXButton.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 16.10.2024.
//

import SwiftUI

struct XButton: View {
    let action: () -> Void
    var body: some View {
        PasteOrXButtonView(systemName: "xmark", title: "", foregroundStyle: .white, strokeColor: .secondary, action: action)
    }
}

#Preview {
    VStack {
        XButton(action: {})
        SmallImageButton(leftIcon: "xmark", foregroundStyle: .white, backGroundStyle: .clear, borderColor: .secondary) {

        }
        .frame(width: 10)
    }
}

struct PasteOrXButtonView: View {
    let systemName: String
    let title: String
    let foregroundStyle: Color
    let strokeColor: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: systemName)
                if !title.isEmpty {
                    Text(title)
                }
            }
            .foregroundStyle(foregroundStyle)
            .font(.footnote)
            .padding(6)
            .padding(.horizontal, title.isEmpty ? 0 : 6)
            .overlay {
                Capsule()
                    .fill(.clear)
                    .stroke(strokeColor)
            }
        }
    }
}
