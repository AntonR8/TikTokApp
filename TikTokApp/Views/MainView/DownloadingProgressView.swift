//
//  DownloadingProgressView.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 28.10.2024.
//

import SwiftUI

struct DownloadingProgressView: View {
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var videosManager: VideosManager
    @Binding var showDownloading: Bool

    func waitForDownloading() {
        print("функция waitForDownloading запущена")
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            showDownloading = false
            if let clipInfo = vm.clipInfo {
                if !clipInfo.videoPreview.isEmpty {
                    print("Запускаю функцию добавления клипа в Recents")
                    videosManager.addClip(to: "Recents", clip: clipInfo)
                } else {
                    print("clipInfo.videoPreview.isEmpty и не добавлен в Recents")
                }
            } else {
                print("vm.clipInfo = nil")
            }
        }

    }

    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
            ProgressView()
                .controlSize(.large)
                .padding()
                .background(
                    .ultraThinMaterial
                )
                .cornerRadius(10)
        }
        .onAppear {
            waitForDownloading()
        }
    }
}

#Preview {
    MainTabView()
     .environmentObject(ViewModel())
     .environmentObject(VideosManager())
}
