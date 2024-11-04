//
//  TrackListRow.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 01.11.2024.
//

import SwiftUI

struct TrackListRow: View {
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var musicManager: MusicManager
    let track: TrackModel
    var folder: MusicFolderModel
    @State var saved: Bool = true

    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: "https" + track.cover.dropFirst(4))) { image in
                    if let image = image.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipped()
                            .cornerRadius(5)
                    } else {
                        ProgressView()
//                            .frame(height: UIScreen.main.bounds.width-32)
                    }
                }
                VStack(alignment: .leading) {
                    Text(track.title)
                    Text(track.creator)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Button {
                    vm.selectedType = "Music"
                    saved.toggle()
                    musicManager.removeTrack(from: folder.name, track: track)
                } label: {
                    Image(systemName: saved ? "bookmark.fill" : "bookmark")
                        .padding(.horizontal, 8)
                        .foregroundStyle(saved ? .red : .secondary)
                }
                PlayButton(destination: URL(string: track.url)!)
            }
            Divider()
        }
        .padding()
    }
}

    #Preview {
        MainTabView()
         .environmentObject(ViewModel())
         .environmentObject(MusicManager())
    }
