//
//  FifthView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 13.09.2024.
//

import SwiftUI

struct FifthView: View {
    @AppStorage("firstRun") var firstRun = true
    @EnvironmentObject var vm: ViewModel

    var body: some View {
        ZStack {
            VStack {
                Image("onboarding5")
                    .resizable()
                    .scaledToFit()
                Spacer()
            }.ignoresSafeArea()
            VStack {
                Spacer()
                Image("shadow")
                    .resizable()
                    .scaledToFit()
            }.ignoresSafeArea()
            VStack {
                Spacer()
                Image(systemName: "star")
                    .font(.largeTitle)
                    .foregroundStyle(.gray)
                    .padding()
                Text("Stay on trend!")
                    .font(.title3)
                    .bold()
                    .padding(.bottom, 4)
                Text("Don't miss the new trends")
                    .font(.footnote)
                    .padding(.bottom, 32)
                Button {
                    requestAuthorization()
                } label: {
                    OnboardingButtonLabel(title: "Turn on notifications")
                }
                DotsNavigationView(number: 5)
            }
            .navigationBarBackButtonHidden(true)
            .overlay(alignment: .topLeading) {
                SmallImageButton(leftIcon: "xmark", foregroundStyle: .white) {
                    firstRun = false
                    vm.showPaywall = true
                    vm.launchScreenOpacity = 0
                }.padding()
            }
        }
    }

    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
            if let error = error {
                print("Ошибка или отказ: \(error)")
            } else {
                switch success {
                case true:
                    print("Запрос на отправку уведомлений одобрен")
                case false: print("Запрос на отправку уведомлений отклонен")
                }
            }
        }
    }
}

#Preview {
    FifthView()
        .environmentObject(ViewModel())
}
