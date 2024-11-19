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
                    FirstRunLaunchScreen()
            } else {
                LaunchScreen()
                    .opacity(vm.launchScreenOpacity)
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
