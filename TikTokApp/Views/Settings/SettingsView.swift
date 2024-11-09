//
//  SettingsView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 12.09.2024.
//

import SwiftUI
import ApphudSDK

struct SettingsView: View {
    @EnvironmentObject var vm: ViewModel

    var body: some View {
        List {
            if !vm.proSubscriptionBought {
                SettingsPurchasesView()
            }
            SettingsActionsView()
            SupportUsSection()
            InfoAndLegalSection()
        }
        .foregroundStyle(.primary)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .environmentObject(ViewModel())
            .environmentObject(VideosManager())
    }
}
