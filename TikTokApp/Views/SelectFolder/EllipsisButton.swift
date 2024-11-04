//
//  EllipsisButton.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 30.10.2024.
//

import SwiftUI

struct EllipsisButton: View {
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var videosManager: VideosManager
    @EnvironmentObject var musicManager: MusicManager
    let folderName: String

    var body: some View {
        Image(systemName: "ellipsis")
            .foregroundStyle(.accent)
            .frame(minWidth: 0)
            .contextMenu(menuItems: {
                if vm.selectedType == "Videos" {
                    Button("Rename", systemImage: "pencil") {
                        videosManager.oldFolderName = folderName
                        videosManager.newFolderName = folderName
                        vm.showChangeFolderNameAllert = true
                    }
                    Divider()
                    Button("Delete", systemImage: "trash", role: .destructive, action: {
                        videosManager.deleteFolder(folderName: folderName)

                    })
                } else if vm.selectedType == "Music" {
                    Button("Rename", systemImage: "pencil") {
                        musicManager.oldFolderName = folderName
                        musicManager.newFolderName = folderName
                        musicManager.showChangeFolderNameAllert = true
                    }
                    Divider()
                    Button("Delete", systemImage: "trash", role: .destructive, action: {
                        musicManager.deleteFolder(folderName: folderName)
                    })
                }
            })
    }
}

#Preview {
    EllipsisButton(folderName: "")
        .environmentObject(ViewModel())
        .environmentObject(VideosManager())
        .environmentObject(MusicManager())
}
