//
//  FirstView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 13.09.2024.
//

import SwiftUI

struct OnboardingView: View {
    let title: String
    let description: String
    let number: Int
    let icon: String
    let buttonTitle: String
    let destination: AnyView

    var body: some View {
        ZStack {
            VStack {
                Image("onboarding\(number.description)")
                    .resizable()
                    .scaledToFit()
                Spacer()
            }.ignoresSafeArea()
            VStack {
                Spacer()
                Image("shadow")
                    .resizable()
                    .scaledToFit()
            }.ignoresSafeArea()
            VStack {
                Spacer()
                Image(systemName: icon)
                    .font(.largeTitle)
                    .foregroundStyle(.gray)
                    .padding()
                Text(title)
                    .font(.title3)
                    .bold()
                    .padding(.bottom, 4)
                Text(description)
                    .font(.footnote)
                    .padding(.bottom, 32)
                NavigationLink(destination: destination,
                               label: { OnboardingButtonLabel(title: buttonTitle) })
                DotsNavigationView(number: number)
            }
            .navigationBarBackButtonHidden(true)

        }
    }
}

#Preview {
    NavigationStack {
        OnboardingView(title: "Download HD quality videos", description: "Share with Friends", number: 1, icon: "square.and.arrow.down", buttonTitle: "Continue", destination: AnyView(SecondView()))
    }
}
