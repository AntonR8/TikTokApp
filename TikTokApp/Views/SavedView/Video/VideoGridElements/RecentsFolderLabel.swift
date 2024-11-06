//
//  RecentsFolderLabel.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 17.10.2024.
//

import SwiftUI

struct RecentsFolderLabel: View {
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var videosManager: VideosManager
    let folderSize: CGFloat = UIScreen.main.bounds.width/2 - 24
    let imagecornerRadius: CGFloat = 8
    let frameCornerRadius: CGFloat = 20
    var recentsFolder: VideoFolderModel? { videosManager.returnFolder(folderName: "Recents") }
    var recentsFolderCount: Int { recentsFolder?.clips.count ?? 0 }
    var recentsFourclips: [ClipInfoModel] { createrecentsFourclips()  }

    func createrecentsFourclips() -> [ClipInfoModel] {
        guard
            let recentsFolder,
            recentsFolderCount > 0
        else {
            print("recentsFolderCount = 0")

            return []
        }

        var clips: [ClipInfoModel] = []
        for i in 1...recentsFolderCount {
            let fetchedClip = recentsFolder.clips[recentsFolderCount-i]
            clips.append(fetchedClip)
        }
        print(recentsFolderCount.description)
        return clips
    }

    init() {
//        print(recentsFolderCount.description)
    }

    var body: some View {
        RoundedRectangle(cornerRadius: frameCornerRadius)
            .fill(.gray.opacity(0.2))
            .frame(width: folderSize, height: folderSize)
            .overlay {
                LazyVGrid(columns: [GridItem(), GridItem()], spacing: 8, content: {
                    ForEach(0..<4) { number in
                        RoundedRectangle(cornerRadius: imagecornerRadius)
                            .fill(.gray.opacity(0.1))
                            .frame(width: folderSize/2-16, height: folderSize/2-16)
                            .overlay {
                                if recentsFolderCount > number {
                                    let currentURL = recentsFourclips[number].videoPreview
                                    AsyncImage(url: URL(string: currentURL)) { image in
                                        if let image = image.image {
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: folderSize/2-16, height: folderSize/2-16)
                                                .clipShape(RoundedRectangle(cornerRadius: imagecornerRadius))
                                        } else {
                                            ProgressView()
                                        }
                                    }
                                }
                            }
                    }

                })
                .padding(12)
            }



    }
}

#Preview {
    RecentsFolderLabel()
     .environmentObject(ViewModel())
     .environmentObject(VideosManager())
}
