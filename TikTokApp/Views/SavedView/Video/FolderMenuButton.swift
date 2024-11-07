//
//  FolderMenuButton.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 31.10.2024.
//

import SwiftUI

struct FolderMenuButton: View {
    @EnvironmentObject var videosManager: VideosManager
    @EnvironmentObject var vm: ViewModel
    let folderName: String
    let action: DismissAction

    var body: some View {
        Image(systemName: "ellipsis")
            .frame(minWidth: 0)
            .foregroundStyle(.accent)
            .contextMenu(menuItems: {
                Button("Rename", systemImage: "pencil") {
                    vm.showChangeFolderNameAllert = true
                    videosManager.oldFolderName = folderName
                    videosManager.newFolderName = folderName

                }
                Divider()
                Button("Delete", systemImage: "trash", role: .destructive, action: {
                    videosManager.deleteFolder(folderName: folderName)
                    action()
                } )
            })
    }
}

