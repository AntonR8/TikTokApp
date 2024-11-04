//
//  TikTokAppApp.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 15.10.2024.
//

import SwiftUI

@main
struct TikTokAppApp: App {
    @EnvironmentObject var vm: ViewModel
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(ViewModel())
                .environmentObject(VideosManager())
                .environmentObject(MusicManager())
        }
    }
}
