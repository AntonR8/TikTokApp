//
//  DataManager.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 30.10.2024.
//
import SwiftUI
import Photos

class VideosManager: ObservableObject {
    @Published var videos: [VideoFolderModel] {
        didSet { saveVideos() }
    }

    @Published var oldFolderName = ""
    @Published var newFolderName = ""
    @Published var clipForAdd: ClipInfoModel?
    @Published var showAddedToFolder = false
    @Published var showVideoSaved = false
    @Published var showVideoNOTSaved = false

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

    // clips:
    func addClip(to folderName: String, clip: ClipInfoModel) {
        if let index = videos.firstIndex(where: {$0.name == folderName}) {
            if videos[index].clips.last?.name != clip.name {
                videos[index] = videos[index].addClip(clip: clip)
                print("Клип \(clip.description) в \(folderName) добавлен")
                if !(folderName == "Recents") {
                    showAddedToFolder = true
                }
            }
        } else {
            print("Ошибка добавления клипа")
        }
    }

    func removeClip(from folderName: String, clip: ClipInfoModel) {
        if let index = videos.firstIndex(where: {$0.name == folderName}) {
            videos[index] = videos[index].deleteClip(clip: clip)
        }
    }

    // download video:
    func getData(from videoURL: String) async -> Data? {
        let url = URL(string: videoURL)!
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print("Ошибка загрузки данных HTTPURLResponse.statusCode: \(response.statusCode)")
                    if response.statusCode == 403 {
                        print("403 Forbidden («запрещено (не уполномочен)»)")
                    }
                    return nil
                } else {
                    print("Данные успешно скачены")
                }
            }
            return data
        } catch let error {
            print("Ошибка URLSession: \(error.localizedDescription)")
            return nil
        }
    }

    func getPath(fileName: String, fileExtension: String) -> URL? {
        guard
            let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?
                .appendingPathComponent ("\(fileName).\(fileExtension)")
        else {
            print ("Error getting path.")
            return nil
        }
        return path
    }

    func saveDataToPath(data: Data, path: URL) {
        print("Запуск сохранения data в path")
        do {
            try data.write(to: path)
        } catch let error {
            print("Ошибка сохранения data в path: \(error.localizedDescription)")
        }

    }

    func saveVideoFromPathTpGallery(path: URL) {
        print("Запуск сохранения video в gallery")
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: path)
        }) { completed, error in
            if completed {
                print("Видео успешно сохранено в Фотогалерею")
                DispatchQueue.main.async{
                    self.showVideoSaved = true
                }
            }
            if let error {
                print("Ошибка сохранения видео в Фотогалерею: \(error)")
                self.showVideoNOTSaved = true
            }
        }
    }

    func downloadAndSaveVideoToGallery(videoURL: String) {
        Task {
            if let data = await getData(from: videoURL) {
                if let path = getPath(fileName: "tempFile", fileExtension: "mp4") {
                    saveDataToPath(data: data, path: path)
                    saveVideoFromPathTpGallery(path: path)
                } else { print("Ошибка сохранения фото или видео в галлерею: - path отсутствует -") }
            } else { print("Ошибка сохранения фото или видео в галлерею: - data отсутствует -") }
        }
    }

}
