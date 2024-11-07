//
//  CoverButton.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 17.10.2024.
//

import SwiftUI

struct CoverButton: View {
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var videosManager: VideosManager
    let clip: ClipInfoModel
    let folderName: String

    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.black.opacity(0.4)) 
            .frame(width: 32, height: 32)
            .overlay {
                Image(systemName: "ellipsis")
            }
            .contextMenu(menuItems: {
                Button("Add...", systemImage: "bookmark") {
                    vm.showSelectFolders = true
                    videosManager.clipForAdd = clip
                }
                Divider()
                Button("Remove", systemImage: "trash", role: .destructive, action: {
                    videosManager.removeClip(from: folderName, clip: clip)
                } )
            })
    }
}

#Preview {
    ZStack {
        Color.gray
        CoverButton(
            vm: .init(),
            videosManager: .init(),
            clip: ClipInfoModel(username: "", name: "", avatar: "", videoPreview: "", description: "", musicTitle: "", musicUrl: ""), folderName: "")
        .environmentObject(ViewModel())
        .environmentObject(VideosManager())
    }
}
