//
//  SelectFolder.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 18.10.2024.
//

import SwiftUI

struct SelectFolder: View {
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var videosManager: VideosManager
    @EnvironmentObject var musicManager: MusicManager
    @State var selectedFolder: String? = nil

    func saveButtonAction() {
        if let selectedFolder {
            if vm.selectedType == "Videos" {
                if let clipInfo = videosManager.clipForAdd {
                    videosManager.addClip(to: selectedFolder, clip: clipInfo)
                    print("clipInfo сохранен в \(selectedFolder)")
                } else { print("clipInfo пустой") }
            } else if vm.selectedType == "Music" {
                if let track = musicManager.trackForAdd {
                    musicManager.addTrack(to: selectedFolder, track: track)
                    print("track сохранен в \(selectedFolder)")
                } else { print("clipInfo пустой") }

            }
        } else { print("selectedFolder отсутствует") }
        vm.showSelectFolders = false
    }

    func renameFolderSaveAction() {
        if vm.selectedType == "Videos" {
            videosManager.changeFolderName(from: videosManager.oldFolderName, to: videosManager.newFolderName)
            videosManager.newFolderName = ""
            videosManager.oldFolderName = ""
        } else if vm.selectedType == "Music" {
            musicManager.changeFolderName(from: videosManager.oldFolderName, to: videosManager.newFolderName)
            musicManager.newFolderName = ""
            musicManager.oldFolderName = ""
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Select folder")
                    .font(.title3)
                    .bold()
                Spacer()
                SmallImageButton(leftIcon: "xmark", foregroundStyle: .white, action: {
                    vm.showSelectFolders = false
                })
            }
            .padding()
            FolderList(selectedFolder: $selectedFolder)
            HStack {
                CapsuleButton(leftIcon: "plus", title: "New folder", backgroundColor: .clear, foregroundColor: .accent) {
                    print("vm.selectedType = \(vm.selectedType)")
                    if vm.selectedType == "Videos" {
                        print("vm.showCreateVideosFolderAllert = true")
                        vm.showCreateVideosFolderAllert = true
                    } else if vm.selectedType == "Music" {
                        print("vm.showCreateMusicFolderAllert = true")
                        vm.showCreateMusicFolderAllert = true
                        print("showCreateMusicFolderAllert = true")
                    }
                }
                CapsuleButton(leftIcon: "checkmark", title: "Save", rightIcon: "") {
                    saveButtonAction()
                }
                .disabled(selectedFolder == nil)
            }
            .padding()
        }
        .alert("Rename folder", isPresented: $vm.showChangeFolderNameAllert) {
            TextField("Folder name", text: $videosManager.newFolderName)
            Button("Cancel",  action: {
                vm.showChangeFolderNameAllert = false
            })
            .accentColor(.accent)
            Button("Save", action: {
                renameFolderSaveAction()
                vm.showChangeFolderNameAllert = false
            })
        } message: { Text("Enter a new name for your folder") }
    }
}

#Preview {
    SelectFolder()
        .environmentObject(ViewModel())
        .environmentObject(VideosManager())
        .environmentObject(MusicManager())
}
