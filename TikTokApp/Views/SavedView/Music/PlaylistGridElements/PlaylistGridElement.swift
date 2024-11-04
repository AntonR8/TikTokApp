//
//  PlaylistGridElement.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 01.11.2024.
//

import SwiftUI

struct PlaylistGridElement: View {
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var musicManager: MusicManager
    let frameCornerRadius: CGFloat
    let playlist: CountryChart
    let folderSize: CGFloat

    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink(destination: {
                AlbumView(country: playlist)
            }, label: {
                PlaylistLabel(country: playlist, width: folderSize, height: folderSize)
            })
            Label(playlist.title, systemImage: "music.note.list")
        }

    }
}


#Preview {
    MainTabView()
        .environmentObject(ViewModel())
        .environmentObject(VideosManager())
        .environmentObject(MusicManager())
}
