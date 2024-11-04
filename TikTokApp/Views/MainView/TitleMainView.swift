//
//  TitleMainView.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 28.10.2024.
//

import SwiftUI

struct TitleMainView: View {
    var body: some View {
        Image(systemName: "music.note")
            .font(.largeTitle)
            .foregroundStyle(.secondary)
            .padding()
        Text("Save TikTok Video")
            .font(.title3)
            .bold()
        Text("Enter the link address below")
            .opacity(0.8)
            .font(.footnote)
            .padding(.bottom, 20)
    }
}

#Preview {
    TitleMainView()
}
