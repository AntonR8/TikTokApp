//
//  FourthSlide.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 17.10.2024.
//

import SwiftUI

struct FourthSlide: View {
    let image: String
    let title: String
    let text: String
    @Binding var showInstruction: Bool

    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 48)
            Text(title)
                .font(.title3)
                .bold()
                .padding(.top ,8)
            Text(text)
                .font(.footnote)
            CapsuleButton(title: "Got it!", action: {
                showInstruction = false
            })
            .padding(.top, 40)
        }
        .padding()
    }
}

#Preview {
    FourthSlide(image: "forth", title: "Fourth step", text: "Open our app and paste the link", showInstruction: .constant(true))
}
