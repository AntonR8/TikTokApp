//
//  PaywallView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 13.09.2024.
//

import SwiftUI
import ApphudSDK

struct PaywallView: View {
    @EnvironmentObject var vm: ViewModel
    @AppStorage("firstRun") var firstRun = true
    @State var showCloseButton: Bool = false



    var body: some View {
        ZStack {
            PaywallBackground()
            VStack {
                if showCloseButton {
                    CloseButton()
                        .transition(.opacity)
                }
                Spacer()
                LogoAndAdvantages()
                SubscriptionsOptions()
                    .padding(.vertical)
                Label("Cancel anytime", systemImage: "clock.arrow.circlepath")
                    .font(.footnote)
                    .padding(.top)
                if !vm.disableContinueButton() {
                    CapsuleButton(leftIcon: "", title: "Continue", rightIcon: "arrow.forward", backgroundColor: vm.disableContinueButton() ? .gray : nil ,action: {
                        vm.makePurchase()
                    })
                    .padding(.vertical)
                }


                PrivacyPolicyLinks()
            }
            .padding(.horizontal)
            .onAppear {
                Task {
                    sleep(2)
                    showCloseButton = true
                }
            }
        }
    }
}

#Preview {
    NavigationStack{
        PaywallView()
            .environmentObject(ViewModel())
    }
}
