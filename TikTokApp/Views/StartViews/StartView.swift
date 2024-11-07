//
//  StartView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 16.09.2024.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var vm: ViewModel
    @AppStorage("firstRun") var firstRun = true
   

    var body: some View {
        ZStack {
            MainTabView()
            if firstRun {
                PaywallView()
                    .onDisappear {
                        vm.showReviewRequest = true
                        }
            }
            LaunchScreen()
                .opacity(vm.launchScreenOpacity)
                .onAppear{
                    print("it is firstRun: \(firstRun)")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation(.easeOut(duration: 1)) {
                            if !firstRun {
                                vm.launchScreenOpacity = 0
                            }
                        }
                    }
                }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    StartView()
        .environmentObject(ViewModel())
        .environmentObject(VideosManager())
        .environmentObject(MusicManager())
}
