//
//  ProButtonView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 12.09.2024.
//

import SwiftUI

struct ProButtonView: View {
    var title: String? = "PRO"

    var body: some View {
        HStack {
            Image(systemName: "crown.fill")
                .font(title != nil ? .caption : .headline)
            if let title {
                Text(title)
                    .bold()
            }

        }
        .padding(title != nil ? 6 : 10)
        .padding(.horizontal, title != nil ? 6 : 0)
        .padding(.horizontal, title != nil ? 0 : -2)
        .foregroundStyle(.white)
        .background(
            Capsule()
                .foregroundStyle(Color.accentColor.gradient)
        )
    }
}

#Preview {
    ProButtonView(title: nil)
}
