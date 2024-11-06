//
//  PreView.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 17.10.2024.
//

import SwiftUI
import StoreKit

struct PreView: View {
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var videosManager: VideosManager
    @Environment(\.requestReview) var requestReview
    
    var clipInfo: ClipInfoModel? { vm.clipInfo }
    let tiktokLink: String
    let clipLink: String

    var body: some View {
        VStack {
            if let clipInfo {
                VideoPreview(info: clipInfo, clipLink: clipLink)
                Menu(link: clipLink, info: clipInfo)
                    .padding(.bottom)
                CapsuleButton(leftIcon: "crown", title: "Save HD", action: {
                    videosManager.downloadAndSaveVideoToGallery(videoURL: vm.tikTokdownloadLink)
                })
            } else {
                Text("Some problems, try again")
            }
        }
        .overlay(alignment: .top) {
            PreviewNotifications()
        }
        .padding(.horizontal)
        .navigationTitle("Preview")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $vm.showSelectFolders) {
            SelectFolder()
                .presentationDetents([.medium])
        }
        .popover(isPresented: $vm.showRateMeView, content: {
            RateMeView()
        })
        .alert("New folder", isPresented: $vm.showCreateVideosFolderAllert) {
            NewfolderAllertbody()
        } message: { Text("Enter a name for your folder for the new video collection") }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if vm.numberOfDownloads == 2 {
                    requestReview()
                }
            }
        }
    }
}



