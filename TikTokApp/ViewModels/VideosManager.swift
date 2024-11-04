//
//  DataManager.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 30.10.2024.
//
import SwiftUI

class VideosManager: ObservableObject {
    @Published var videos: [VideoFolderModel] {
        didSet { saveVideos() }
    }

    @Published var oldFolderName = ""
    @Published var newFolderName = ""
    @Published var clipForAdd: ClipInfoModel?
    @Published var showAddedToFolder = false

    init () {
        let recents = VideoFolderModel(clips: [], name: "Recents")
        let saved = VideoFolderModel(clips: [], name: "Saved")
        self.videos = [recents, saved]

        guard
            let videosData = UserDefaults.standard.data(forKey: "videos"),
            let savedVideos = try? JSONDecoder().decode([VideoFolderModel].self, from: videosData)
        else { return }
        self.videos = savedVideos
    }

    // init:
    func saveVideos() {
        if let encodedData = try? JSONEncoder().encode(videos) {
            UserDefaults.standard.setValue(encodedData, forKey: "videos")
        }
    }

    // folders:
    func addFolder(folderName: String) {
        let newFolder = VideoFolderModel(clips: [], name: folderName)
        videos.append(newFolder)
        saveVideos()
        guard
            let videosData = UserDefaults.standard.data(forKey: "videos"),
            let savedVideos = try? JSONDecoder().decode([VideoFolderModel].self, from: videosData)
        else { return }
        self.videos = savedVideos
    }

    func deleteFolder(folderName: String) {
        if folderName == "Recents" || folderName == "Saved" { return }
        if let index = videos.firstIndex(where: {$0.name == folderName}) {
            videos.remove(at: index)
        }
    }

    func changeFolderName(from oldName: String, to newName: String) {
        if let index = videos.firstIndex(where: {$0.name == oldName}) {
            videos[index] = videos[index].changeName(newName: newName)
        }
    }

    func returnFolder(folderName: String) -> VideoFolderModel? {
        videos.first(where: {$0.name == folderName})
    }

    // add / remove clips:
    func addClip(to folderName: String, clip: ClipInfoModel) {
        if let index = videos.firstIndex(where: {$0.name == folderName}) {
            videos[index] = videos[index].addClip(clip: clip)
            print("Клип \(clip.description) в \(folderName) добавлен")
            showAddedToFolder = true
        } else {
            print("Ошибка добавления клипа")
        }
    }

    func removeClip(from folderName: String, clip: ClipInfoModel) {
        if let index = videos.firstIndex(where: {$0.name == folderName}) {
            videos[index] = videos[index].deleteClip(clip: clip)
        }
    }

    func moveClip(from folderName: String, clip: ClipInfoModel, to newFolderName: String) {
        removeClip(from: folderName, clip: clip)
        addClip(to: newFolderName, clip: clip)
    }
}
