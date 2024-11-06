//
//  GridView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 12.09.2024.
//

import SwiftUI

struct VideoGrid: View {
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var videosManager: VideosManager
    let frameCornerRadius: CGFloat = 20

    func returnIcon(folder: String) -> String {
        switch folder {
        case "Saved": "bookmark"
        case "Recents": "clock.arrow.circlepath"
        default: "folder"
        }
    }

    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem()], spacing: 16,content: {
            ForEach(videosManager.videos, id: \.self) { folder in
                VideoGridElement(frameCornerRadius: frameCornerRadius, folderName: folder.name, icon: returnIcon(folder: folder.name))
            }
        })
        .id(UUID())
        .alert("New folder", isPresented: $vm.showCreateVideosFolderAllert) {
            NewfolderAllertbody()
        } message: { Text("Enter a name for your folder for the new video collection") }
    }
}

#Preview { 
    MainTabView()
        .environmentObject(ViewModel())
        .environmentObject(VideosManager())
        .environmentObject(MusicManager())
}
