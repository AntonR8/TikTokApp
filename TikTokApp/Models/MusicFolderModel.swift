import Foundation

struct MusicFolderModel: Codable, Hashable {
    let tracks: [TrackModel]
    let name: String

    func addTrack(track: TrackModel) -> MusicFolderModel {
        var instanseTracks: [TrackModel] = tracks
        instanseTracks.append(track)
        return MusicFolderModel(tracks: instanseTracks, name: name)
    }

    func deleteTrack(track: TrackModel) -> MusicFolderModel {
        var instanseTracks: [TrackModel] = tracks
        if let index = instanseTracks.firstIndex(where: {$0.url == track.url}) {
            instanseTracks.remove(at: index)
        }
        return MusicFolderModel(tracks: instanseTracks, name: name)
    }

    func changeName(newName: String) -> MusicFolderModel {
        return MusicFolderModel(tracks: tracks, name: newName)
    }
}
