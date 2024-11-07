//
//  PlayButton.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 21.10.2024.
//

import SwiftUI

struct PlayButton: View {
    let destination: URL
    var body: some View {
        Link(destination: destination) {
            Image(systemName: "play.fill")
                .foregroundColor(.white)
                .padding(8)
                .background(.accent)
                .clipShape(Circle())
        }
    }
}

#Preview {
    PlayButton(destination: URL(string: "https://www.apple.com")!)
}
