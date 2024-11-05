//
//  SettingsActionsView.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 15.10.2024.
//

import SwiftUI

struct SettingsActionsView: View {
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var videosManager: VideosManager
    @EnvironmentObject var musicManager: MusicManager
    var cacheSize: Int { MemoryLayout.size(ofValue: videosManager.videos) + MemoryLayout.size(ofValue: musicManager.music) + MemoryLayout.size(ofValue: musicManager.savedPlaylists) - 24 }
    @State var notofications: Bool = false

    var body: some View {
        Section(header: Text("Actions")) {
            HStack {
                SettingsElementLabel(image: "bell.badge", title: "Notifications", showChevron: true)
                Spacer()
                Toggle("", isOn: $notofications)
                    .toggleStyle(SwitchToggleStyle(tint: .accent))
                    .onChange(of: notofications) {
                        if let url = URL(string: UIApplication.openNotificationSettingsURLString) {
                                if UIApplication.shared.canOpenURL(url) {
                                    Task { await UIApplication.shared.open(url) }
                                }
                            }
                    }
            }

            SettingsButton(image: "trash", title: "Clear cache", action: {
                videosManager.videos = []
                musicManager.music = []
                musicManager.savedPlaylists = []

            }, description: "\(cacheSize) MB")

        }
        .textCase(nil)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .environmentObject(ViewModel())
            .environmentObject(VideosManager())
            .environmentObject(MusicManager())
    }
}
