//
//  SubscriptionsOptionsView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 27.09.2024.
//

import SwiftUI

struct SubscriptionsOptions: View {
    @EnvironmentObject var vm: ViewModel
    @State var annualSubscriptionChosen = true
    @State var weeklySubscriptionChosen = false

    var body: some View {
        if vm.products.isEmpty {
            Text("⚠️ no Internet connection")
        } else {
            VStack {
                Button {
                    annualSubscriptionChosen = true
                    weeklySubscriptionChosen = false
                    let productName = "yearly_19.99_no-trial"
                    vm.chosenSubscription = vm.products.first(where: { $0.name == productName })
                } label: {
                    SubscriptionButton(isChosen: $annualSubscriptionChosen, subscriptionName: "Annual", pricePerYear: "Just $0.42 per week", bestOffer: true, pricePerPeriod: "$19.99", period: "per year", subscription: nil)
                }
                .padding(.vertical, 8)
                Button(action: {
                    annualSubscriptionChosen = false
                    weeklySubscriptionChosen = true
                    let productName = "weekly_4.99_notrial"
                    vm.chosenSubscription = vm.products.first(where: { $0.name == productName })
                }, label: {
                    SubscriptionButton(isChosen: $weeklySubscriptionChosen, subscriptionName: "Weekly", pricePerYear: nil, bestOffer: false, pricePerPeriod: "$4.99", period: "per week", subscription: nil)
                })
            }
        }
    }
}

#Preview {
    SubscriptionsOptions()
        .environmentObject(ViewModel())
}
