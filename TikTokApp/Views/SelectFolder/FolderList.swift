//
//  FolderList.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 18.10.2024.
//

import SwiftUI


struct FolderList: View {
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var videosManager: VideosManager
    @EnvironmentObject var musicManager: MusicManager
    @Binding var selectedFolder: String?

    var body: some View {
        if vm.selectedType == "Videos" {
            List {
                if !videosManager.videos.isEmpty {
                    ForEach(videosManager.videos, id: \.self) {folder in
                        if folder.name != "Recents" {
                            ListElement(folderName: folder.name, selectedFolder: $selectedFolder)
                        }
                    }
                }
            }
        } else if vm.selectedType == "Music" {
            List {
                if !musicManager.music.isEmpty {
                    ForEach(musicManager.music, id: \.self) {folder in
                        ListElement(folderName: folder.name, selectedFolder: $selectedFolder)
                    }
                }
            }
        }
    }
}


#Preview {
    FolderList(selectedFolder: .constant(""))
        .environmentObject(ViewModel())
        .environmentObject(VideosManager())
        .environmentObject(MusicManager())
}
