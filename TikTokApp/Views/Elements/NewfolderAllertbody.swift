//
//  NewfolderAller.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 28.10.2024.
//

import SwiftUI

struct NewfolderAllertbody: View {
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var videosManager: VideosManager
    @EnvironmentObject var musicManager: MusicManager
    @State var folderName: String = ""

    func savePushed() {
        if vm.savedViewSelection == "Videos" {
            videosManager.addFolder(folderName: folderName)
        } else if vm.savedViewSelection == "Music" {
            musicManager.addFolder(folderName: folderName)
        }
    }

    var body: some View {
        TextField("Folder name", text: $folderName)
        Button("Cancel",  action: {
            vm.showCreateMusicFolderAllert = false
            vm.showCreateVideosFolderAllert = false
        })
        .accentColor(.accent)
        Button("Save", action: {
            savePushed()
            folderName  = ""
            vm.showSelectFolders = true
        })
    }
}

#Preview {
    NewfolderAllertbody()
        .environmentObject(ViewModel())
        .environmentObject(VideosManager())
        .environmentObject(MusicManager())
}

