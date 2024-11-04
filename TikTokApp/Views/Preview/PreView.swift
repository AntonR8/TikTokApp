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
                    vm.saveVideo()
                })
            } else {
                Text("clipInfo is nil")
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
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if vm.numberOfDownloads == 2 {
                    requestReview()
                }
            }
        }
    }
}



