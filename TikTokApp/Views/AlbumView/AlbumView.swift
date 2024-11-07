//
//  AlbumView.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 21.10.2024.
//

import SwiftUI
import StoreKit

struct AlbumView: View {
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var musicManager: MusicManager
    @Environment(\.requestReview) var requestReview
    
    @State var showAddedToSavedAlert = false
    let country: CountryChart
    @State var selectedTrack: TrackModel?
    var albumAddedToPlaylists: Bool { musicManager.checkIfPlaylistIsSaved(playlist: country) }
    @Environment(\.dismiss) var dismiss

    func buttonSavePlaylistAction() {
        if albumAddedToPlaylists {
            musicManager.removePlaylist(playlist: country)
            dismiss()
        } else {
            withAnimation {
                musicManager.addPlaylist(playlist: country)
                showAddedToSavedAlert = true
                vm.numberOfMusicSavings += 1
            }
        }
    }

    var body: some View {
        ScrollView {
            CoverView(showAddedToSavedAlert: $showAddedToSavedAlert, country: country)
            VStack {
                ForEach(0..<country.music.count) { number in
                    ListRow(number: number+1, track: country.music[number])
                        .frame(height: UIScreen.main.bounds.width/8.5)
                }
            }
            .padding()
        }
        .ignoresSafeArea()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    buttonSavePlaylistAction()
                } label: {
                    Image(systemName: albumAddedToPlaylists ? "bookmark.fill" : "bookmark")
                        .foregroundStyle(albumAddedToPlaylists ? .accent : .white)
                }
            }
        }
        .accentColor(.white)
        .onAppear {
            vm.albumViewIsShowing = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if vm.numberOfMusicSavings == 2 {
                    requestReview()
                }
            }
        }
        .onDisappear {
            vm.albumViewIsShowing = false
        }
        .sheet(isPresented: $vm.showSelectFolders) {
            SelectFolder()
                .presentationDetents([.height(450)])
        }
    }

}

#Preview {
    MainTabView()
     .environmentObject(ViewModel())
     .environmentObject(MusicManager())
}
