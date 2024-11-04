//
//  CircleButton.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 18.10.2024.
//

import SwiftUI

struct CircleButton: View {
    @Binding var isChosen: Bool
    var action: () -> Void

    var body: some View {
        Button {
            withAnimation(.easeInOut) {
                isChosen.toggle()
                action()
            }
        } label: {
            Image(systemName: isChosen ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(isChosen ? .accent : .secondary)
                .background(Circle().fill(isChosen ? .white : .clear).padding(1))
        }
        .accentColor(.primary)
    }
}


#Preview {
    CircleButton(isChosen: .constant(false), action: {})
}
