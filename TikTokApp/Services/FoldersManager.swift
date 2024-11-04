//
//  FileManager.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 17.10.2024.
//

import SwiftUI

class FoldersManager {
    static let shared = FoldersManager()
    private let directoryType: FileManager.SearchPathDirectory = .documentDirectory
    private var directory: URL?
    private init() {
        self.directory = initRootDirectory(directoryType: directoryType)
    }

    // init:
    private func initRootDirectory(directoryType: FileManager.SearchPathDirectory) -> URL? {
        guard
            let directory = FileManager.default.urls(for: directoryType, in: .userDomainMask).first
        else {
            print("Ошибка доступа к \(directoryType). Предположительно массив с директориями пуст или доступ запрещен")
            return nil
        }
        return directory
    }

    private func createVideosFolder() {
        createRootFolder(folderName: "Videos")
    }

    private func createMusicFolder() {
            createRootFolder(folderName: "Music")
        }

    private func createRootFolder(folderName: String) {
        guard
            let path = self.directory?.appendingPathComponent(folderName).path
        else {
            print("Ошибка создания папки \(folderName): указан не верный путь: \(String(describing: directory)). ")
            return
        }
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                print ("Папка \(folderName) успешно создана.")
            } catch let error {
                print ("Ошибка создания папки \(path): \(error)")
            }
        }
    }

    private func createRecentsFolderInVideos() {
        createFolder(folderName: "Recents", inFolder: "Videos")
    }

    private func createSavedFolderInVideos() {
        createFolder(folderName: "Saved", inFolder: "Videos")
    }

    private func createSavedFolderInMusic() {
        createFolder(folderName: "Saved", inFolder: "Music")
    }

    func createFolder(folderName: String, inFolder: String) {
        guard
            let path = self.directory?.appendingPathComponent(inFolder).appendingPathComponent(folderName).path
        else {
            print("Ошибка создания папки \(folderName) в папке \(inFolder): указан не верный путь: \(String(describing: directory)). ")
            return
        }
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                print ("Папка \(folderName) в папке \(inFolder) успешно создана.")
            } catch let error {
                print ("Ошибка создания папки \(folderName) в папке \(inFolder): \(path): \(error)")
            }
        }
    }


    // interface:
    func returnFoldersInVideos() -> [String] {
        returnFoldersInFolder("Videos")
    }

    func returnFoldersInMusic() -> [String] {
        returnFoldersInFolder("Music")
    }

    func returnFoldersInFolder(_ folderName: String) -> [String] {
        var folders: [String] = []
        guard let directory else { return folders }
        let folderDirectory = directory.appendingPathComponent(folderName)
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: folderDirectory, includingPropertiesForKeys: nil, options: [])
            folders = directoryContents.map{$0.lastPathComponent}
        } catch let error {
            print("Ошибка извлечения содержимого папки \(folderName): \(error)")
        }
        return folders
    }



//    func getImage(name: String) -> UIImage? {
//        guard
//            let path = getPathForImage(name: name)?.path,
//            FileManager.default.fileExists(atPath: path)
//        else {
//            print("Error getting path.")
//            return nil
//        }
//        return UIImage(contentsOfFile: path)
//    }

//    func deleteImage(name: String) {
//        guard
//            let path = getPathForImage(name: name),
//            FileManager.default.fileExists(atPath: path.path)
//        else {
//            print ("Error getting path.")
//            return
//        }
//
//        do {
//            try FileManager.default.removeItem(at: path)
//            print("Image deleted")
//        } catch let error {
//            print("Error deleting image: \(error)")
//        }
//    }

    func deleteFolder(folderName: String) {
        if let directory {
            let path = directory.appendingPathComponent(folderName).path
            do {
                try FileManager.default.removeItem(atPath: path)
                print ("Success deleting folder.")
            } catch let error {
                print ("Error deleting folder: \(error)")
            }
        }
    }


    func saveURL(url: String, name: String, rootFolder: String, folderName: String) {
        guard
            let data = url.data(using: .utf8),
            let path = getPathForURL(name: name, rootFolder: rootFolder, folderName: folderName)
        else {
            print("Ошибка сохранения URL или ошибка пути")
            return
        }

        do {
            try data.write(to: path)
            print("URL saved")
        } catch let error {
            print("Error saving URL: \(error)")
        }
    }

    func getPathForURL(name: String, rootFolder: String, folderName: String) -> URL? {
        guard
            let path = directory?
                .appendingPathComponent(rootFolder)
                .appendingPathComponent(folderName)
                .appendingPathComponent ("\(name).txt")
        else {
            print ("Error getting path.")
            return nil
        }
        return path
    }



//    private func clearFolderNameFromPath(folder: String) -> String {
//        let arrayOfPathCharacters = folder.components(separatedBy: "/Documents/")
//        guard
//            arrayOfPathCharacters.count > 1
//        else {
//            print ("Error getting folder name: folder name is nil.")
//            return ""
//        }
//        let pathEndingCharacters = arrayOfPathCharacters[1]
//        let result = pathEndingCharacters.components(separatedBy: "/")[0]
//    return result
//    }

}
