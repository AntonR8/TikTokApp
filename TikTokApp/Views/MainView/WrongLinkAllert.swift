//
//  WrongLinkAllert.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 22.10.2024.
//

import SwiftUI

struct WrongLinkAllert: View {
    var body: some View {
        Text("Sorry, this link is not supported, please insert another one")
            .font(.subheadline)
            .multilineTextAlignment(.center)
            .foregroundStyle(.white)
            .padding()
            .background(.accent)
            .cornerRadius(14)
    }
}

#Preview {
    WrongLinkAllert()
}
