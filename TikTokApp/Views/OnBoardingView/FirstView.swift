//
//  FirstView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 13.09.2024.
//

import SwiftUI

struct FirstView: View {
    
    var body: some View {
        OnboardingView(
            title: "Download HD quality videos",
            description: "Share with Friends",
            number: 1,
            icon: "square.and.arrow.down",
            buttonTitle: "Continue",
            destination: AnyView(SecondView())
        )
    }
}

#Preview {
    FirstView()
}
