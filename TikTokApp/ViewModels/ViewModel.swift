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

extension ApphudPurchaseResult {
    var success: Bool {
        subscription?.isActive() ?? false ||
            nonRenewingPurchase?.isActive() ?? false ||
            (Apphud.isSandbox() && transaction?.transactionState == .purchased)
    }
}

enum ApphudPlacement {
//    case settings
//    case myProjects
//    case onboarding
//    case luboyDrugoy
    case test

    var placementIdentifier: String {
        switch self {
//        case .settings: "settings"
//        case .myProjects: "my_projects"
//        case .onboarding: "onboarding"
//        case .luboyDrugoy: "tvoe nazvanie id kak v apphud"
        case .test: "test"
        }
    }
}

class ViewModel: ObservableObject {
    
    @AppStorage("firstRun") var firstRun = true

    // Apphud
    private var currentPlacement: ApphudPlacement = .test
    private var currentPaywall: ApphudPaywall?
    @Published var products: [ApphudProduct] = []
    @Published var selectedProductIndex = 0

    // Paywall
    @Published var proSubscriptionBought = false
    @Published var showPaywall: Bool = false

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
            await loadProducts(for: currentPlacement)
        }

        self.proSubscriptionBought = Apphud.hasActiveSubscription()
        Apphud.setDeviceIdentifiers(idfa: nil, idfv: UIDevice.current.identifierForVendor?.uuidString)
        fetchIDFA()
    }





    // MARK: - Functions:

    // Paywall
    @MainActor private func loadProducts(for placement: ApphudPlacement) async {
        Apphud.fetchPlacements { placements, apphudError in
            guard let actualPlacement = placements.first(where: { $0.identifier == placement.placementIdentifier })
            else { return }

            guard let actualPaywall = actualPlacement.paywall else { return }
            self.currentPaywall = actualPaywall

            self.products = actualPaywall.products
            print("products successfully fetched: \(self.products.map { $0.name })")
        }
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

    func updatedSelectedProductIndex(_ index: Int) {
        selectedProductIndex = index
    }

    @MainActor func makePurchase() {
        guard let selectedProduct = products[safe: selectedProductIndex] else { return }
        Apphud.purchase(selectedProduct) {result in
            if let error = result.error {
                DispatchQueue.main.async {
                    self.firstRun = false
                }
                print("Ошибка выполнения Apphud.purchase")
                debugPrint(error.localizedDescription)
            }
            if let subscription = result.subscription, subscription.isActive() {
                self.proSubscriptionBought = true
                self.showPaywall = false
                DispatchQueue.main.async {
                    self.firstRun = false
                }
            } else if let purchase = result.nonRenewingPurchase, purchase.isActive() {
                self.proSubscriptionBought = true
                self.showPaywall = false
                DispatchQueue.main.async {
                    self.firstRun = false
                }
            } else {
                if Apphud.hasActiveSubscription() {
                    self.proSubscriptionBought = true
                    self.showPaywall = false
                    DispatchQueue.main.async {
                        self.firstRun = false
                    }
                }
            }
        }
    }

    func func1() {
        if Apphud.hasPremiumAccess() {
            // проверка на любую активную покупку
        }
    }


    @MainActor func restorePurchase() {
        Apphud.restorePurchases {subscriptions, _, error in
            if let error = error {
                print("Ошибка восставноления подписки")
                debugPrint(error.localizedDescription)
                // подписка не активка либо другая ошибка - обработка ошибку
            }
            if subscriptions?.first?.isActive() ?? false {
                self.showPaywall = false
                return
            }

            if Apphud.hasActiveSubscription() {
                self.showPaywall = false
            }
        }
    }

    func returnSubscriptionViewParameters(subscription: ApphudProduct) -> (subscriptionName: String, pricePerYear: String?, bestOffer: Bool, pricePerPeriod: String, period: String)? {
        switch subscription.productId {
        case "yearly_19.99_no_trial": (subscriptionName: "Annual", pricePerYear: "Just $0.42 per week", bestOffer: true, pricePerPeriod: "$19.99", period: "per year")
        case "weekly_4.99_notrial": (subscriptionName: "Weekly", pricePerYear: nil, bestOffer: false, pricePerPeriod: "$4.99", period: "per week")
        default: nil
        }
    }


    func disableContinueButton() -> Bool {
        guard
            !products.isEmpty,
            let _ = products[safe: selectedProductIndex]
        else { return true }

        return false
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
