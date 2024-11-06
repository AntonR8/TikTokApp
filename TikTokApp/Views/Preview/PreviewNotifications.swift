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
        VStack {
            if videosManager.showVideoSaved {
                CapsuleNotification(iconName: "checkmark.circle.fill", message: "Video saved")
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                            videosManager.showVideoSaved = false
                        }
                    }
            }

            if videosManager.showVideoNOTSaved {
                CapsuleNotification(iconName: "exclamationmark.triangle.fill", message: "Error saving video")
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                            videosManager.showVideoNOTSaved = false
                        }
                    }
            }

            if vm.showTrackNameCopied {
                CapsuleNotification(iconName: "checkmark.circle.fill", message: "Track name copied")
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                            vm.showTrackNameCopied = false
                        }
                    }
            }
            
            if vm.showAudioSavedToFiles {
                CapsuleNotification(iconName: "checkmark.circle.fill", message: "Saved audio from video")
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                            vm.showAudioSavedToFiles = false
                        }
                    }
            }
            
            if musicManager.showAddedToFolder {
                CapsuleNotification(iconName: "checkmark.circle.fill", message: "Added to folder")
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                            musicManager.showAddedToFolder = false
                        }
                    }
            }
            
            if videosManager.showAddedToFolder {
                CapsuleNotification(iconName: "checkmark.circle.fill", message: "Added to folder")
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                            videosManager.showAddedToFolder = false
                        }
                    }
            }
            
            
        }
        .padding(.top, 30)
    }
}

#Preview {
    PreviewNotifications()
        .environmentObject(ViewModel())
        .environmentObject(MusicManager())
        .environmentObject(VideosManager())
}
