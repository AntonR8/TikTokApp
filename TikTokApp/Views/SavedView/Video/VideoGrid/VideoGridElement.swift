//
//  GridElementView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 12.09.2024.
//

import SwiftUI

struct VideoGridElement: View {
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var videosManager: VideosManager
    let frameCornerRadius: CGFloat
    let folderName: String
    let icon: String
    let imageSize: CGFloat = UIScreen.main.bounds.width/2 - 32

    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink(destination: {
                VideoFolderView(folderName: folderName)
            }, label: {
                if folderName == "Recents" {
                    RecentsFolderLabel()
                } else {
                    VideoGridElementLabel(folderName: folderName, frameCornerRadius: frameCornerRadius)
                }
            })
            Label(folderName, systemImage: icon)
        }

    }
}



#Preview {
    MainTabView()
        .environmentObject(ViewModel())
        .environmentObject(VideosManager())
        .environmentObject(MusicManager())
}
