//
//  ImageView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 26.09.2024.
//

import SwiftUI

struct VideoFolderView: View {
    @EnvironmentObject var videosManager: VideosManager
    @EnvironmentObject var vm: ViewModel
    @Environment(\.dismiss) var dismiss
    let folderName: String
    var folder: VideoFolderModel? { videosManager.returnFolder(folderName: folderName) }
    var folderClipsCount: Int { folder?.clips.count ?? 0 }

//    func returnNavigationTitle() -> String {
//        
//    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(folderClipsCount) saved videos")
                .font(.footnote)
                .padding(.horizontal)
                .navigationTitle(folderName)
            if let clips = folder?.clips {
                if clips.isEmpty {
                    NoVideosView(folderName: folderName)
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(), GridItem()], spacing: 8,content: {
                            ForEach(clips, id: \.self) { clip in
                                VideoCover(clip: clip, folderName: folderName)
                            }

                        })
                    }
                    .padding(16)
                }
            } else {
                NoVideosView(folderName: folderName)
            }


        }
        .sheet(isPresented: $vm.showSelectFolders) {
            SelectFolder()
                .presentationDetents([.medium])
        }

        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if folderName != "Saved" && folderName != "Recents" {
                    FolderMenuButton(folderName: folderName, action: dismiss)
                }
            }
        }
        .alert("Rename folder", isPresented: $vm.showChangeFolderNameAllert) {
            TextField("Folder name", text: $videosManager.newFolderName)
            Button("Cancel",  action: {
                vm.showChangeFolderNameAllert = false
            })
            .accentColor(.accent)
            Button("Save", action: {
                videosManager.changeFolderName(from: videosManager.oldFolderName, to: videosManager.newFolderName)
                videosManager.newFolderName = ""
                videosManager.oldFolderName = ""
                vm.showChangeFolderNameAllert = false
            })
        }
    }
}


#Preview {
    NavigationStack {
        VideoFolderView(folderName: "Recents")
            .environmentObject(ViewModel())
            .environmentObject(VideosManager())
    }
}
