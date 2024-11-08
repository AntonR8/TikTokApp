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

    let selectedProductIndex: Int
    let subscription: ApphudProduct


    var parameters: (subscriptionName: String, pricePerYear: String?, bestOffer: Bool, pricePerPeriod: String, period: String)? { vm.returnSubscriptionViewParameters(subscription: subscription)}


    var body: some View {
        Button {
            vm.updatedSelectedProductIndex(selectedProductIndex)
            print(vm.selectedProductIndex.description)
        } label: {
            HStack() {
                Image(systemName: selectedProductIndex == vm.selectedProductIndex ? "button.programmable" : "circle")
                    .foregroundStyle(selectedProductIndex == vm.selectedProductIndex ? .accent : .secondary)
                VStack(alignment: .leading) {
                    Text(parameters?.subscriptionName ?? subscription.productId)
                    if let pricePerYear = parameters?.pricePerYear {
                        Text(pricePerYear)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .foregroundStyle(.white)
                Spacer()
                VStack {
                    if let parameters, parameters.bestOffer {
                        BestOfferBadgeView()
                    }
                    Spacer()
                }
                VStack(alignment: .trailing) {
                    Text(parameters?.pricePerPeriod ?? "⚠️")
                        .font(.headline)
                    Text(parameters?.period ?? "")
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
                RoundedRectangle(cornerRadius: 14).stroke(selectedProductIndex == vm.selectedProductIndex ? .accent : .clear)
            }
            .padding(1)
        }

    }
}

#Preview {
    SubscriptionsOptions()
        .environmentObject(ViewModel())
}


