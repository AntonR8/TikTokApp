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
            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                showDownloading = false
                if let clipInfo = vm.clipInfo {
                    if !clipInfo.videoPreview.isEmpty {
                        print("Запускаю функцию добавления клипа в Recents")
                        videosManager.addClip(to: "Recents", clip: clipInfo)
                        print(vm.clipInfo!.videoPreview)
                    } else {
                        print("😢clipInfo.videoPreview.isEmpty")
                    }
                } else {
                    print("vm.clipInfo = nil")
                }
            }
        }
    }
}

#Preview {
    MainTabView()
     .environmentObject(ViewModel())
     .environmentObject(VideosManager())
}
