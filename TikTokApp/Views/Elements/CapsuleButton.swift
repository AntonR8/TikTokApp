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
    var foregroundColor: Color?
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
            .foregroundStyle(foregroundColor ?? .white)
            .frame(maxWidth: .infinity)
            .frame(height:  44)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(.accent, lineWidth: 1)
                    .fill(backgroundColor ?? .accent)
            )
            .padding(1)
        }
    }
}

#Preview {
    CapsuleButton(leftIcon: "photo.badge.plus", title: "Add Photo", action: {})
}
