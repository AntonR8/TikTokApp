//
//  CloseButton.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 16.10.2024.
//

import SwiftUI

struct CloseButton: View {
    @EnvironmentObject var vm: ViewModel

    var body: some View {
        HStack {
            SmallImageButton(leftIcon: "xmark", foregroundStyle: .white, backGroundStyle: .black.opacity(0.5), action: {
                vm.firstLaunchPaywall = false
                vm.showPaywall = false
            })
            Spacer()
        }
    }
}

#Preview {
    CloseButton()
        .environmentObject(ViewModel())
}