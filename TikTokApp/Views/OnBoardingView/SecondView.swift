//
//  SecondView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 13.09.2024.
//

import SwiftUI

struct SecondView: View {
    var body: some View {
        OnboardingView(
            title: "Make your collections",
            description: "Add Favorite Videos",
            number: 2,
            icon: "bookmark",
            buttonTitle: "Continue",
            destination: AnyView(ThirdView()))
    }
}

#Preview {
    SecondView()
}
