//
//  PreviewNotifications.swift
//  TikTokApp
//
//  Created by АнтохаПрограммист on 04.11.2024.
//

import SwiftUI

struct PreviewNotifications: View {
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var musicManager: MusicManager
    @EnvironmentObject var videosManager: VideosManager
    
    var body: some View {
        ZStack {
            if vm.showVideoSaved {
                CapsuleNotification(iconName: "checkmark.circle.fill", message: "Video saved")
                    .padding(.top, 40)
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                            vm.showVideoSaved = false
                        }
                    }
            }

            if vm.showVideoNOTSaved {
                CapsuleNotification(iconName: "exclamationmark.triangle.fill", message: "Error saving video")
                    .padding(.top, 40)
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                            vm.showVideoNOTSaved = false
                        }
                    }
            }

            if vm.showTrackNameCopied {
                CapsuleNotification(iconName: "checkmark.circle.fill", message: "Track name copied")
                    .padding(.top, 40)
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                            vm.showTrackNameCopied = false
                        }
                    }
            }
            
            if vm.showAudioSavedToFiles {
                CapsuleNotification(iconName: "checkmark.circle.fill", message: "Saved audio from video")
                    .padding(.top, 40)
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                            vm.showAudioSavedToFiles = false
                        }
                    }
            }
            
            if musicManager.showAddedToFolder {
                CapsuleNotification(iconName: "checkmark.circle.fill", message: "Added to folder")
                    .padding(.top, 40)
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                            musicManager.showAddedToFolder = false
                        }
                    }
            }
            
            if videosManager.showAddedToFolder {
                CapsuleNotification(iconName: "checkmark.circle.fill", message: "Added to folder")
                    .padding(.top, 40)
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
                            videosManager.showAddedToFolder = false
                        }
                    }
            }
            
            
        }
    }
}

#Preview {
    PreviewNotifications()
        .environmentObject(ViewModel())
        .environmentObject(MusicManager())
        .environmentObject(VideosManager())
}
