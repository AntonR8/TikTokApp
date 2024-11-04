//
//  MusicGrid.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 17.10.2024.
//

import SwiftUI

struct MusicGrid: View {
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var musicManager: MusicManager
    let frameCornerRadius: CGFloat = 20

    let height: CGFloat = 202.4
    let imageHeight: CGFloat = 138.4
    let folderSize: CGFloat = UIScreen.main.bounds.width/2 - 24

    func returnIcon(folder: String) -> String {
        switch folder {
        case "Saved": "bookmark"
        default: "folder"
        }
    }

    var body: some View {
        LazyVGrid(columns: [GridItem(alignment: .top), GridItem(alignment: .top)], spacing: 16 ,content: {
            ForEach(musicManager.music, id: \.self) { folder in
                MusicGridElement(frameCornerRadius: frameCornerRadius, folderName: folder.name, icon: returnIcon(folder: folder.name))
            }
            ForEach(musicManager.savedPlaylists, id: \.self) { playlist in
                PlaylistGridElement(frameCornerRadius: frameCornerRadius, playlist: playlist, folderSize: folderSize)
            }
        })
        .alert("New folder", isPresented: $vm.showCreateMusicFolderAllert) {
            NewfolderAllertbody()
        } message: { Text("Enter a name for your folder for the new music collection") }
            .sheet(isPresented: $vm.showSelectFolders) {
                SelectFolder()
                    .presentationDetents([.medium])
            }
    }
}

#Preview {
    MainTabView()
        .environmentObject(ViewModel())
        .environmentObject(VideosManager())
        .environmentObject(MusicManager())
}
