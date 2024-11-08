//
//  SubscriptionsOptionsView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 27.09.2024.
//

import SwiftUI
import ApphudSDK

struct SubscriptionsOptions: View {
    @EnvironmentObject var vm: ViewModel

    var body: some View {
        if vm.products.isEmpty {
            Text("⚠️ no connection to the server")
        } else {
            VStack(spacing: 8) {

                ForEach( Array(zip(vm.products.indices, vm.products)), id: \.0) { index, product in
                    SubscriptionButton(selectedProductIndex: index, subscription: product)
                }
            }
        }
    }
}

#Preview {
    SubscriptionsOptions()
        .environmentObject(ViewModel())
}
