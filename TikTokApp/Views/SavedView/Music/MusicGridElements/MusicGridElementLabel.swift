//
//  MusicGridElementLabel.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 01.11.2024.
//

import SwiftUI

struct MusicGridElementLabel: View {
    @EnvironmentObject var musicManager: MusicManager
    let folderName: String
    let folderSize: CGFloat = UIScreen.main.bounds.width/2 - 24
    let imagecornerRadius: CGFloat = 16
    let frameCornerRadius: CGFloat
    var folder: MusicFolderModel? { musicManager.returnFolder(folderName: folderName) }

    var body: some View {
        RoundedRectangle(cornerRadius: frameCornerRadius)
            .fill(.gray.opacity(0.2))
            .frame(width: folderSize, height: folderSize)
            .overlay {
                if let folder {
                    if let trackCover = folder.tracks.last?.cover {
                        AsyncImage(url: URL(string: "https" + trackCover.dropFirst(4))) { image in
                            if let image = image.image {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: folderSize-24, height: folderSize-24)
                                    .clipShape(RoundedRectangle(cornerRadius: imagecornerRadius))
                            } else {
                                ProgressView()
                            }
                        }
                    }
                    else {
                        RoundedRectangle(cornerRadius: imagecornerRadius)
                            .fill(.gray.opacity(0.1))
                            .frame(width: folderSize-24, height: folderSize-24)
                    }
                }
            }

    }
}

#Preview {
    MainTabView()
        .environmentObject(ViewModel())
        .environmentObject(VideosManager())
        .environmentObject(MusicManager())
}
