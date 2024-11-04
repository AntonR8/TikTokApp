//
//  Menu.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 17.10.2024.
//

import SwiftUI

struct Menu: View {
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var videosManager: VideosManager
    let link: String
    let info: ClipInfoModel

    var body: some View {
        HStack(alignment: .top) {
            ShareLink(item: URL(string: link)!) {
                MenuElement(icon: "square.and.arrow.up", title: "Share video")
            }

            Button {
                vm.selectedType = "Videos"
                if vm.clipInfo != nil {
                    videosManager.clipForAdd = vm.clipInfo
                    vm.showSelectFolders = true
                } else { print("clipInfo ПУСТОЙ") }
            } label: { MenuElement(icon: "bookmark", title: "Add...") }

            Button {
                vm.showTrackNameCopied = true
            } label: { MenuElement(icon: "doc.on.doc", title: "Copy track name") }
            
            Button {
                vm.saveClipAudio()
                vm.showAudioSavedToFiles = true
            } label: { MenuElement(icon: "waveform", title: "Save audio") }
            
        }
        .foregroundStyle(.primary)
    }
}

