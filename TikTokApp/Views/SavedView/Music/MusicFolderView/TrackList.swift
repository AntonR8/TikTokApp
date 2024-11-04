//
//  TrackList.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 01.11.2024.
//

import SwiftUI

struct TrackList: View {
    var folder: MusicFolderModel

    var body: some View {
        VStack {
            ForEach(folder.tracks, id: \.self) { track in
                TrackListRow(track: track, folder: folder)

            }

        }
        .listStyle(.plain)
    }
}

//#Preview {
//    Mus()
//}
