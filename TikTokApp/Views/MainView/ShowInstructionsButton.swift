//
//  ShowInstructionsButton.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 28.10.2024.
//

import SwiftUI

struct ShowInstructionsButton: View {
    @Binding var showInstruction: Bool

    var body: some View {
        Button {
            showInstruction = true
        } label: {
            Label("Where to get the link", systemImage: "questionmark.circle")
                .font(.subheadline)
        }
        .foregroundStyle(.secondary)
        .padding()
    }
}

#Preview {
    ShowInstructionsButton(showInstruction: .constant(false))
}
