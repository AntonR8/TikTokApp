//
//  PaywallBackground.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 16.10.2024.
//

import SwiftUI

struct PaywallBackground: View {
    var body: some View {
        VStack {
            Image("paywall")
                .resizable()
                .scaledToFit()
            Spacer()
        }
        .ignoresSafeArea()
        .overlay {
            VStack {
                Spacer()
                LinearGradient(colors: [.black, .black, .clear], startPoint: .bottom, endPoint: .top)
            }
        }
    }
}

#Preview {
    PaywallBackground()
}
