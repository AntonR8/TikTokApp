//
//  SavedView.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 16.10.2024.
//

import SwiftUI

struct SavedView: View {
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var videosManager: VideosManager
    @EnvironmentObject var musicManager: MusicManager
    
    var body: some View {
        VStack {
            Picker("Pick", selection: $vm.savedViewSelection) {
                Text("Videos").tag("Videos")
                Text("Music").tag("Music")
            }
            .pickerStyle(.palette)
            .padding(.vertical, 8)

            ScrollView {
                if vm.savedViewSelection == "Videos" {
                    VideoGrid()
                } else {
                    MusicGrid()
                }

            }
        }
        .padding()

    }
}

#Preview {
       MainTabView()
        .environmentObject(ViewModel())
        .environmentObject(VideosManager())
        .environmentObject(MusicManager())
}
