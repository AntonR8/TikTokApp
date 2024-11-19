//
//  ForthView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 13.09.2024.
//

import SwiftUI
import StoreKit

struct ForthView: View {
    @Environment(\.requestReview) var requestReview
    @State var raitingRequested = false



    var body: some View {
        ZStack {
            VStack {
                Image("onboarding4")
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
                Image(systemName: "star")
                    .font(.largeTitle)
                    .foregroundStyle(.gray)
                    .padding()
                Text("Rate our app in the AppStore")
                    .font(.title3)
                    .bold()
                    .padding(.bottom, 4)
                Text("Your feedback is important")
                    .font(.footnote)
                    .padding(.bottom, 32)
                NavigationLink(destination: FifthView(),
                               label: { OnboardingButtonLabel(title: "Continue") })
                .disabled(!raitingRequested)
                .onTapGesture {
                    requestReview()
                    raitingRequested = true
                }
                DotsNavigationView(number: 4)
            }
            .navigationBarBackButtonHidden(true)

        }


    }
}

#Preview {
    NavigationStack {
        ForthView()
    }
}
