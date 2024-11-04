//
//  AdvantagesView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 27.09.2024.
//

import SwiftUI

struct LogoAndAdvantages: View {
    var body: some View {
        Text("Get it all with PRO")
            .font(.largeTitle)
            .bold()
        VStack(alignment: .leading, spacing: 10) {
            Label(
                title: { Text("Download HD TikTok videos") },
                icon: { Image(systemName: "checkmark") }
            )
            Label(
                title: { Text("Trending music collections") },
                icon: { Image(systemName: "checkmark") }
            )
            Label(
                title: { Text("Unlimited folders") },
                icon: { Image(systemName: "checkmark") }
            )
        }
        .labelStyle(.iconTint(.electric))
        .padding(.vertical)
    }
}

#Preview {
    LogoAndAdvantages()
}
