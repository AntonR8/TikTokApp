import SwiftUI

class MusicManager: ObservableObject {
    @Published var music: [MusicFolderModel] {
        didSet { saveMusic() }
    }

    @Published var savedPlaylists: [CountryChart] {
        didSet { savePlaylists() }
    }

    @Published var showChangeFolderNameAllert = false
    @Published var oldFolderName = ""
    @Published var newFolderName = ""
    @Published var trackForAdd: TrackModel?
    @Published var showAddedToFolder = false

    init () {
        let saved = MusicFolderModel(tracks: [], name: "Saved")
        self.music = [saved]
        self.savedPlaylists = []
        guard
            let musicData = UserDefaults.standard.data(forKey: "music"),
            let savedMusic = try? JSONDecoder().decode([MusicFolderModel].self, from: musicData)
        else { return }
        self.music = savedMusic

        guard
            let playlistsData = UserDefaults.standard.data(forKey: "savedPlaylists"),
            let playlists = try? JSONDecoder().decode([CountryChart].self, from: playlistsData)
        else { return }
        self.savedPlaylists = playlists
    }

    // init:
    func saveMusic() {
        if let encodedData = try? JSONEncoder().encode(music) {
            UserDefaults.standard.setValue(encodedData, forKey: "music")
        }
    }

    func savePlaylists() {
        if let encodedData = try? JSONEncoder().encode(savedPlaylists) {
            UserDefaults.standard.setValue(encodedData, forKey: "savedPlaylists")
        }
    }

    // folders:
    func addFolder(folderName: String) {
        let newFolder = MusicFolderModel(tracks: [], name: folderName)
        music.append(newFolder)
        saveMusic()
        guard
            let musicData = UserDefaults.standard.data(forKey: "music"),
            let savedMusic = try? JSONDecoder().decode([MusicFolderModel].self, from: musicData)
        else { return }
        self.music = savedMusic
    }

    func deleteFolder(folderName: String) {
        if folderName == "Saved" { return }
        if let index = music.firstIndex(where: {$0.name == folderName}) {
            music.remove(at: index)
        }
    }

    func changeFolderName(from oldName: String, to newName: String) {
        if let index = music.firstIndex(where: {$0.name == oldName}) {
            music[index] = music[index].changeName(newName: newName)
        }
    }

    func returnFolder(folderName: String) -> MusicFolderModel? {
        music.first(where: {$0.name == folderName})
    }

    // add / remove clips:
    func addTrack(to folderName: String, track: TrackModel) {
        if let index = music.firstIndex(where: {$0.name == folderName}) {
            music[index] = music[index].addTrack(track: track)
            print("Трек \(track.title) в \(folderName) добавлен")
            showAddedToFolder = true
        } else {
            print("Ошибка добавления клипа")
        }
    }

    func removeTrack(from folderName: String, track: TrackModel) {
        if let index = music.firstIndex(where: {$0.name == folderName}) {
            music[index] = music[index].deleteTrack(track: track)
        }
    }

    //playlists::
    func addPlaylist(playlist: CountryChart) {
        savedPlaylists.append(playlist)
    }

    func removePlaylist(playlist: CountryChart) {
        if let index = savedPlaylists.firstIndex(where: {$0.id == playlist.id}) {
            savedPlaylists.remove(at: index)
        }
    }

    func checkIfPlaylistIsSaved(playlist: CountryChart) -> Bool {
        savedPlaylists.contains(playlist)
    }
}
