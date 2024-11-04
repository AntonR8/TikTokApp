//
//  SettingsActionsView.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 15.10.2024.
//

import SwiftUI

struct SettingsActionsView: View {
    @EnvironmentObject var vm: ViewModel
    let cacheSize: String = "5 MB"

    var body: some View {
        Section(header: Text("Actions")) {

            HStack {
                SettingsElementLabel(image: "bell.badge", title: "Notifications", showChevron: true)
                Spacer()
                Toggle("", isOn: .constant(true))
                    .toggleStyle(SwitchToggleStyle(tint: .accent))
            }

            SettingsButton(image: "trash", title: "Clear cache", action: { }, description: cacheSize)

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
