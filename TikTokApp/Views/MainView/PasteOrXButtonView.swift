//
//  PasteOrXButton.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 16.10.2024.
//

import SwiftUI

struct XButton: View {
    let systemName: String = "xmark"
    let foregroundStyle: Color = .white
    let strokeColor: Color = .gray.opacity(0.7)
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .foregroundStyle(foregroundStyle)
                .font(.footnote)
                .padding(6)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.clear)
                        .stroke(strokeColor)
                }
        }
    }
}

#Preview {
    XButton(action: {})

}
