//
//  NoMusicView.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 01.11.2024.
//

import SwiftUI

struct NoMusicView: View {
    var body: some View {
        Spacer()
        VStack {
            Image(systemName: "folder")
                .font(.largeTitle)
                .foregroundStyle(.secondary)
                .padding(4)
            Text("No music")
                .font(.title3)
                .bold()
                .padding(8)
            Text("Open any video you want and click “add...” to save it in that folder")
                .font(.footnote)
                .padding(.horizontal, 50)
                .multilineTextAlignment(.center)
        }
        Spacer()
    }
}

#Preview {
    NoMusicView()
}
