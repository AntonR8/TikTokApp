//
//  SettingsSupportUsView.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 16.10.2024.
//

import SwiftUI

struct SupportUsSection: View {
    let appStoreLink = URL(string:"https://apps.apple.com/us/app/tikclip-video-save/id6737406092")!
    @Environment(\.requestReview) var requestReview

    var body: some View {
        Section(header: Text("Support us")) {
            SettingsButton(image: "star", title: "Rate our app", action: { requestReview() }, description: nil)
            SettingsShareLink(shareLink: appStoreLink, image: "square.and.arrow.up", title: "Share with friends")
        }
        .textCase(nil)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .environmentObject(ViewModel())
    }
}
