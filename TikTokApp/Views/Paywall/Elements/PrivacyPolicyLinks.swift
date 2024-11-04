//
//  PrivacyPolicyLinksView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 27.09.2024.
//

import SwiftUI
import ApphudSDK

struct PrivacyPolicyLinks: View {
    let contactURL = URL(string: "https://www.termsfeed.com/live/bbc6cbdc-1b4f-463c-9d61-dd3acb21a3b9")!
    var body: some View {
        HStack {
                Link("Privacy Policy", destination: contactURL)
                    .foregroundStyle(.secondary)
                Spacer()
                Button("Restore Purchases", action:  {
                    Task {
                        await Apphud.restorePurchases()
                    }
                })
                .foregroundStyle(.secondary)
                Spacer()
                Link("Terms of Use", destination: contactURL)
                    .foregroundStyle(.secondary)
            }
            .font(.caption)
    }
}

#Preview {
    PrivacyPolicyLinks()
}
