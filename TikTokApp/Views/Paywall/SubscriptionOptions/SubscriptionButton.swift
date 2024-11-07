//
//  SuscriptionButton.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 13.09.2024.
//

import SwiftUI
import ApphudSDK
import StoreKit

struct SubscriptionButton: View {
    @EnvironmentObject var vm: ViewModel
    @Binding var isChosen: Bool
    let subscriptionName: String
    let pricePerYear: String?
    let bestOffer: Bool
    var pricePerPeriod: String
    let period: String
    var subscription: ApphudProduct?

    var body: some View {

        HStack() {
            Image(systemName: isChosen ? "button.programmable" : "circle")
                .foregroundStyle(isChosen ? .accent : .secondary)
            VStack(alignment: .leading) {
                Text(subscriptionName)
                if let pricePerYear {
                    Text(pricePerYear)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .foregroundStyle(.white)
            Spacer()
            VStack {
                if bestOffer {
                    BestOfferBadgeView()
                }
                Spacer()
            }
            VStack(alignment: .trailing) {
                Text(pricePerPeriod)
                    .font(.headline)
                Text(period)
                    .foregroundStyle(.secondary)
                    .font(.caption)
            }
            .foregroundStyle(.white)
        }

        .padding(8)
        .padding(.horizontal, 8)
        .background(.gray.opacity(0.3))
        .frame(height: 54)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay {
            RoundedRectangle(cornerRadius: 14).stroke(isChosen ? .accent : .clear)
        }
        .padding(1)
    }
}

#Preview {
    SubscriptionsOptions()
        .environmentObject(ViewModel())
}


