//
//  MusicFolderView.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 01.11.2024.
//

import SwiftUI

struct MusicFolderView: View {
    @EnvironmentObject var musicManager: MusicManager
    @EnvironmentObject var vm: ViewModel
    @Environment(\.dismiss) var dismiss
    let folderName: String
    var folder: MusicFolderModel? { musicManager.returnFolder(folderName: folderName) }
    var folderTracksCount: Int { folder?.tracks.count ?? 0 }

//    func returnNavigationTitle() -> String {
//
//    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(folderTracksCount) saved music tracks")
                .font(.footnote)
                .padding(.horizontal)
                .navigationTitle(folderName)
            if let tracks = folder?.tracks {
                if !tracks.isEmpty {
                    TrackList(folder: folder!)
                } else { NoMusicView() }
            } else { NoMusicView() }
            Spacer()
        }
        .sheet(isPresented: $vm.showSelectFolders) {
            SelectFolder()
                .presentationDetents([.medium])
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if folderName != "Saved" {
                    FolderMenuButton(folderName: folderName, action: dismiss)
                }
            }
        }
        .alert("Rename folder", isPresented: $vm.showChangeFolderNameAllert) {
            TextField("Folder name", text: $musicManager.newFolderName)
            Button("Cancel",  action: {
                vm.showChangeFolderNameAllert = false
            })
            .accentColor(.accent)
            Button("Save", action: {
                musicManager.changeFolderName(from: musicManager.oldFolderName, to: musicManager.newFolderName)
                musicManager.newFolderName = ""
                musicManager.oldFolderName = ""
                vm.showChangeFolderNameAllert = false
            })
        }
    }
}


#Preview {
    NavigationStack {
        MusicFolderView(folderName: "Recents")
            .environmentObject(ViewModel())
            .environmentObject(MusicManager())
    }
}
