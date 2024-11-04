//
//  Favourites.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 21.10.2024.
//

import SwiftUI

struct TrendsSection: View {
    @EnvironmentObject var vm: ViewModel
    let section: SectionModel
    var height: CGFloat { section.isMain ? 314 : 192 }
    var imageHeight: CGFloat { section.isMain ? 250 : 128 }

    var body: some View {
        VStack {
            HStack {
                Text(section.title)
                    .font(.title3)
                    .bold()
                Spacer()
                SeeAllButton(destination: AnyView(OpenSection(section: section))  )
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                        ForEach (section.sets) { country in
                            CardView(country: country, width: 200, height: height, imageHeight: imageHeight)

                    }
                }
            }
            .padding(.bottom)
        }
    }
}

#Preview {
    MainTabView()
     .environmentObject(ViewModel())
}
