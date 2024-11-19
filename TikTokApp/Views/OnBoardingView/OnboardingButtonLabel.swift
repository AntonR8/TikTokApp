//
//  OnboardingButton.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 13.11.2024.
//

import SwiftUI

struct OnboardingButtonLabel: View {
    var title: String?

    var body: some View {
        Text(title ?? "")
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(.accent)
            )
    }
}

#Preview {
    OnboardingButtonLabel()
}
