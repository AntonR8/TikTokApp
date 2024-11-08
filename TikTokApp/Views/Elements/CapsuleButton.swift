//
//  NewPhotoButton.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 12.09.2024.
//

import SwiftUI

struct CapsuleButton: View {
    var leftIcon: String?
    var title: String?
    var rightIcon: String?
    var backgroundColor: Color?
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
                if let rightIcon {
                    Image(systemName: rightIcon)
                }
            }
            .foregroundStyle(.white)
            .padding(14)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .foregroundStyle(backgroundColor ?? .red)
            )
        }
    }
}

#Preview {
    CapsuleButton(leftIcon: "photo.badge.plus", title: "Add Photo", rightIcon: "", action: {})
}
