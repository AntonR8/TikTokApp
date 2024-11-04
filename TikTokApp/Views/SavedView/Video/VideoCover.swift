//
//  VideoCover.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 17.10.2024.
//

import SwiftUI

struct VideoCover: View {
    @EnvironmentObject var videosManager: VideosManager
    let clip: ClipInfoModel
    let folderName: String
    var body: some View {
        AsyncImage(url: URL(string: clip.videoPreview)) { image in
            if let image = image.image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width/2 - 24)
                    .clipped()
                    .cornerRadius(10)
                    .overlay(alignment: .topTrailing) {
                        CoverButton(clip: clip, folderName: folderName)
                            .padding(8)
                    }
            } else {
                ProgressView()
            }

        }
    }
}

#Preview {
    NavigationStack {
        VideoFolderView(folderName: "Recents")
            .environmentObject(ViewModel())
            .environmentObject(VideosManager())
    }
}
