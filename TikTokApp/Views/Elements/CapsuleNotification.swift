//
//  CapsuleNotification.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 13.09.2024.
//

import SwiftUI

struct CapsuleNotification: View {
    var iconName: String
    var message: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundStyle(.white, .green)
            Text(message)
                .foregroundStyle(.black)
                .font(.caption)
        }
        .foregroundStyle(.white)
        .padding(8)
        .background(Color.primary)
        .clipShape( Capsule())
    }
}

#Preview {
    CapsuleNotification(iconName: "checkmark.circle.fill", message: "Take a photo")
}
