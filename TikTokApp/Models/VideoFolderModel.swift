//
//  VideoFolderModel.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 01.11.2024.
//

import Foundation

struct VideoFolderModel: Codable, Hashable {
    let clips: [ClipInfoModel]
    let name: String

    func addClip(clip: ClipInfoModel) -> VideoFolderModel {
        var instanseClips: [ClipInfoModel] = clips
        instanseClips.append(clip)
        return VideoFolderModel(clips: instanseClips, name: name)
    }

    func deleteClip(clip: ClipInfoModel) -> VideoFolderModel {
        var instanseClips: [ClipInfoModel] = clips
        if let index = instanseClips.firstIndex(where: {$0.description == clip.description}) {
            instanseClips.remove(at: index)
        }
        return VideoFolderModel(clips: instanseClips, name: name)
    }

    func changeName(newName: String) -> VideoFolderModel {
        return VideoFolderModel(clips: clips, name: newName)
    }
}
