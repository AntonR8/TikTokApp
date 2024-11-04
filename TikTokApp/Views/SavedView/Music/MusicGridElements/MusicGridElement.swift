//
//  MusicGridElement.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 01.11.2024.
//

import SwiftUI

struct MusicGridElement: View {
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var musicManager: MusicManager
    let frameCornerRadius: CGFloat
    let folderName: String
    let icon: String
    let imageSize: CGFloat = UIScreen.main.bounds.width/2 - 32

    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink(destination: {
                MusicFolderView(folderName: folderName)
            }, label: {
                MusicGridElementLabel(folderName: folderName, frameCornerRadius: frameCornerRadius)
            })
            Label(folderName, systemImage: icon) 
        }

    }
}



#Preview {
    MainTabView()
        .environmentObject(ViewModel())
        .environmentObject(VideosManager())
        .environmentObject(MusicManager())
}
