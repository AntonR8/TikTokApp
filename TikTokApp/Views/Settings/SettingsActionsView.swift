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

    func clearCache() {
        // arrays
        let recents = VideoFolderModel(clips: [], name: "Recents")
        let savedV = VideoFolderModel(clips: [], name: "Saved")
        videosManager.videos = [recents, savedV]

        let savedM = MusicFolderModel(tracks: [], name: "Saved")
        musicManager.music = [savedM]
        musicManager.savedPlaylists = []

        // folders
        let documentsUrl = URL.documentsDirectory

        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for fileURL in fileURLs where fileURL.pathExtension == "mp3" {
                try FileManager.default.removeItem(at: fileURL)
            }
        } catch { print(error) }

        let cachesUrl = URL.cachesDirectory

        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: cachesUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for fileURL in fileURLs where fileURL.pathExtension == "mp4" {
                try FileManager.default.removeItem(at: fileURL)
            }
        } catch { print(error) }

    }

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
                clearCache()
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
