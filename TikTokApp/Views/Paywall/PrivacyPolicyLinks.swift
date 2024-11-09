//
//  PrivacyPolicyLinksView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 27.09.2024.
//

import SwiftUI
import ApphudSDK

struct PrivacyPolicyLinks: View {
    @EnvironmentObject var vm: ViewModel

    let privacyPolicyURL = URL(string: "https://www.termsfeed.com/live/42bae468-a349-48f7-be6e-25e9eb7aacaf")!
    let termsOfUseURL = URL(string: "https://www.termsfeed.com/live/f6810b12-ad1f-48d2-b3f5-b0f75bdf6ea9")!

    var body: some View {
        HStack {
                Link("Privacy Policy", destination: privacyPolicyURL)
                    .foregroundStyle(.secondary)
                Spacer()
                Button("Restore Purchases", action:  {
                    vm.restorePurchase()
                })
                .foregroundStyle(.secondary)
                Spacer()
                Link("Terms of Use", destination: termsOfUseURL)
                    .foregroundStyle(.secondary)
            }
            .font(.caption)
    }
}

#Preview {
    PrivacyPolicyLinks()
        .environmentObject(ViewModel())
}
