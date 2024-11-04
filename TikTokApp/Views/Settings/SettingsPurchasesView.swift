//
//  PurchasesView.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 15.10.2024.
//

import SwiftUI
import ApphudSDK

struct SettingsPurchasesView: View {
    @EnvironmentObject var vm: ViewModel

    var body: some View {
        Section(header: Text("Purchases")) {
            SettingsButton(image: "crown", title: "Upgrade plan", action: { vm.showPaywall = true }, description: nil)
            SettingsButton(image: "arrow.counterclockwise", title: "Restore purchases", action: {
                Task {
                    await Apphud.restorePurchases()
                }
            }, description: nil)
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
