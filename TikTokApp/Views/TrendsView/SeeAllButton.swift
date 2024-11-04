//
//  SeeAllButton.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 25.10.2024.
//

import SwiftUI

struct SeeAllButton: View {
    let destination: AnyView

    var body: some View {
        SmallImageLink(
            title: "See all",
            rightIcon: "chevron.right",
            foregroundStyle: .white,
            backGroundStyle: .clear,
            borderColor: .gray.opacity(0.5),
            destination: destination
        )
    }
}

#Preview {
    MainTabView()
     .environmentObject(ViewModel())
}
