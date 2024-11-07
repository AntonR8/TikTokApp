//
//  ListRow.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 21.10.2024.
//

import SwiftUI
import StoreKit

struct ListRow: View {
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var musicManager: MusicManager
    @Environment(\.requestReview) var requestReview
    
    let number: Int
    let track: TrackModel
    let chartGrowing: Bool = .random()
    @State var saved: Bool = false
    

    var body: some View {
        VStack {
            HStack {
                Text(number.description)
                    .font(.subheadline)
                Image(systemName: chartGrowing ? "arrow.up.right" : "arrow.down.right")
                    .font(.subheadline)
                    .foregroundStyle(chartGrowing ? .green : .red)
                AsyncImage(url: URL(string:  "https" + track.cover.dropFirst(4) )) { image in
                    if let image = image.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipped()
                            .cornerRadius(5)
                    } else {
                        ProgressView()
                            .frame(height: UIScreen.main.bounds.width-32)
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
                    musicManager.trackForAdd = track
                    vm.showSelectFolders = true
                    vm.numberOfMusicSavings += 1
                } label: {
                    Image(systemName: saved ? "bookmark.fill" : "bookmark")
                        .padding(.horizontal, 8)
                        .foregroundStyle(saved ? .red : .secondary)
                }
                PlayButton(destination: URL(string: track.url)!)

            }
            Divider()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if vm.numberOfMusicSavings == 2 {
                    requestReview()
                }
            }
        }
    }
}

#Preview {
    MainTabView()
     .environmentObject(ViewModel())
     .environmentObject(MusicManager())
}
