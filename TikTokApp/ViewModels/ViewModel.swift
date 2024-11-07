//
//  ViewModel.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 15.10.2024.
//

import SwiftUI
import AppTrackingTransparency
import ApphudSDK
import StoreKit
import AdSupport

class ViewModel: ObservableObject {

    @AppStorage("firstLaunch") var firstLaunch = true

    // Paywall
    @Published var products: [ApphudProduct] = []
    @Published var chosenSubscription: ApphudProduct?
    @Published var proSubscriptionBought = false
    @Published var showPaywall: Bool = false
    @Published var firstLaunchPaywall = true

    // Navigation
    @Published var tabSelection = 1
    @Published var savedViewSelection = "Videos"
    @Published var path = NavigationPath()

    // Folders
    @Published var showCreateMusicFolderAllert = false
    @Published var showCreateVideosFolderAllert = false
    @Published var showChangeFolderNameAllert = false
    @Published var showSelectFolders = false

    // Interface
    @Published var launchScreenOpacity: CGFloat = 1
    @Published var showAddedToSavedAlert: Bool = false
    @Published var albumViewIsShowing: Bool = false
    @Published var showWrongLinkAlert: Bool = false
    @Published var showVPNLinkAlert: Bool = false
    @Published var selectedType: String = "Music"
    @Published var showRateMeView: Bool = false
    @Published var numberOfDownloads = 0
    @Published var numberOfMusicSavings = 0
    @Published var showTrackNameCopied = false
    @Published var showAudioSavedToFiles = false
    @Published var showReviewRequest = false

    // Downloading
    let downloadManager = DownloadManager()
    @Published var tikTokdownloadLink: String = ""
    @Published var clipInfo: ClipInfoModel?
    @Published var trendsMusic: [SectionModel] = []
   

    init() {
        getTrendsMusic()

        Task {
            await Apphud.start(apiKey: "app_Lq3Eoit1CwyroaFcfpW2RyHXdekMfF")
            await loadProducts()
        }

        self.proSubscriptionBought = Apphud.hasActiveSubscription()
        Apphud.setDeviceIdentifiers(idfa: nil, idfv: UIDevice.current.identifierForVendor?.uuidString)
        fetchIDFA()
    }





    // MARK: - Functions:

    // Paywall
    func loadProducts() async {
        async let loadedPlacement = await Apphud.placement("test")
        let myPlacement = await loadedPlacement

        await MainActor.run {
            self.products = myPlacement?.paywall?.products ?? []
            if products.count > 2 {
                self.chosenSubscription = products[1]
                print("По умолчанию задан продукт: \(chosenSubscription?.name ?? "не задан")")
            } else { print(products.count) }
        }
        print("products successfully fetched: \(products.map { $0.name })")
    }

    func fetchIDFA() {
            if #available(iOS 14.5, *) {
                DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                    ATTrackingManager.requestTrackingAuthorization { status in
                        guard status == .authorized else {return}
                        let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                        Apphud.setDeviceIdentifiers(idfa: idfa, idfv: UIDevice.current.identifierForVendor?.uuidString)
                    }
                }
            }
        }

    func makePurchase(product: ApphudProduct?) {
        Task {
            if let product {
                await Apphud.purchase(product) { result in
                    if result.success {
                        print("Purchase successful")
                        self.proSubscriptionBought = true
                    }
                }
            }
        }
    }

    // interface
    func returnNavigationTitle() -> String {
        switch tabSelection {
        case 1: return "Main"
        case 2: return "Saved"
        case 3: return "Music trends"
        case 4: return "Settings"
        default: return ""
        }
    }

    func mainSectionExists() -> Bool {
        var result: Bool = false
        for item in trendsMusic {
            if item.isMain { result = true }
            else { result = false }
        }
        return result
    }

    func showRateMe() {
        self.showRateMeView = (self.numberOfDownloads % 3 == 0)
    }

    // downloading
    func findButtonPushed(link: String) {
        print("findButtonPushed")
        self.clipInfo = nil
        self.tikTokdownloadLink = ""
        sendPostRequest(link: link)
        getClipInfo(link: link)
        self.numberOfDownloads += 1
        self.showRateMe()
    }

    func sendPostRequest(link: String) {
        downloadManager.postTikTokRequest(link: link) { tikTokdownloadLink in
                self.tikTokdownloadLink = tikTokdownloadLink
                print(tikTokdownloadLink)
        }
    }

    func getClipInfo(link: String) {
        downloadManager.getClipInfo(link: link) { receivedResponse in
            switch receivedResponse.result {
            case .success(let receivedData):
                print("ClipInfo response.error : \(String(describing: receivedData.error))")
                print("ClipInfo response.messages = \(String(describing: receivedData.messages.count))")
                let receivedClipInfo = receivedData.data
                if receivedClipInfo.username.isEmpty {
                    print("!!!!!receivedclipInfo.username.isEmpty")
                    self.showVPNLinkAlert = true
                } else {
                    self.clipInfo = receivedClipInfo
                    self.path.append("go")
                }
            case .failure(let error):
                print("Ошибка получения данных clipInfo: \(error)")
                self.showWrongLinkAlert = true
                print("!!!!!!showWrongLinkAlert = true")
            }
        }
    }

    func saveClipAudio() {
        Task {
            if let clipInfo {
                let mp3data = await downloadManager.downloadTrack(trackurl: clipInfo.musicUrl)
                if let mp3data {
                    downloadManager.saveTrack(data: mp3data, name: clipInfo.musicTitle)
                } else { print("no mp3data") }
            }
        }
    }

    func getTrendsMusic() {
        downloadManager.getMusicTrends { trendsMusic in
            self.trendsMusic = trendsMusic
        }
    }





}
