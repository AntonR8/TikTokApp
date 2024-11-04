//
//  RateMeView.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 16.10.2024.
//

import SwiftUI

struct RateMeView: View {
    @EnvironmentObject var vm: ViewModel
    @Environment(\.openURL) private var openURL
    
    private func requestReviewManually() {
        let url = "https://apps.apple.com/app/id6737406092?action=write-review"
        guard let writeReviewURL = URL(string: url) else {
            fatalError("Expected a valid URL")
        }
        openURL(writeReviewURL)
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
        VStack {
            HStack {
                Spacer()
                SmallImageButton(leftIcon: "xmark", foregroundStyle: .white, action: {
                    vm.showRateMeView = false
                })
                .padding()
            }
            Spacer()
            Image("RateMe")
                .resizable()
                .scaledToFit()
                .padding(.bottom, -16)
            Text("Do you like our app?")
                .font(.largeTitle)
                .bold()
            Text("Please rate our app so we can improve it for you and make it even cooler")
                .multilineTextAlignment(.center)
                .padding()
            VStack {
                CapsuleButton(leftIcon: "heart.fill", title: "Yes, I love it!") {
                    requestReviewManually()
                }
                
                CapsuleEmptyButton(title: "No, i don't") {
                    vm.showRateMeView = false
                }
            }
            .frame(maxWidth: 200)
            Spacer()
        }
    }
    }
}

#Preview {
    RateMeView()
        .environmentObject(ViewModel())
}
