//
//  OpenSection.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 21.10.2024.
//

import SwiftUI

struct OpenSection: View {
    @EnvironmentObject var vm: ViewModel
    let section: SectionModel

    let height: CGFloat = 202.4
    let imageHeight: CGFloat = 138.4

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                ForEach (section.sets, id: \.self) { country in
                    CardView(country: country, width: UIScreen.main.bounds.width/2-24, height: height, imageHeight: imageHeight)
                            .padding(.bottom, 4)
                    
                }
            }
        }
        .padding()
        .navigationTitle(section.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if !vm.proSubscriptionBought {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        vm.showPaywall = true
                    } label: {
                        ProButtonView()
                    }
                }
            }
        }
    }
}

#Preview {
    MainTabView()
     .environmentObject(ViewModel())
}
