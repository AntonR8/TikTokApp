//
//  BackgroundMainView.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 28.10.2024.
//

import SwiftUI

struct BackgroundMainView: View {
    var body: some View {
        Image("mainBackgroundImage")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

#Preview {
    BackgroundMainView()
}
