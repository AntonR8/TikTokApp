//
//  InfoAndLegalSection.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 16.10.2024.
//

import SwiftUI

struct InfoAndLegalSection: View {
    let contactURL = URL(string:"mailto:sevketdemirsoy@hotmail.com")!
    let termsOfUseURL =  URL(string: "https://www.termsfeed.com/live/f6810b12-ad1f-48d2-b3f5-b0f75bdf6ea9")!
    let privacyPolicy =  URL(string:"https://www.termsfeed.com/live/42bae468-a349-48f7-be6e-25e9eb7aacaf")!

    var body: some View {
        Section(header: Text("Info & legal")) {
            Link(destination: contactURL) {
                SettingsElementLabel(image: "envelope", title: "Contact us")
            }
            Link(destination: privacyPolicy) {
                SettingsElementLabel(image: "person.badge.shield.checkmark", title: "Privacy Policy")
            }
            Link(destination: termsOfUseURL) {
                SettingsElementLabel(image: "doc.text", title: "Usage Policy")
            }
        }
        .textCase(nil)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .environmentObject(ViewModel())
            .environmentObject(VideosManager())
            .environmentObject(MusicManager())
    }
}
