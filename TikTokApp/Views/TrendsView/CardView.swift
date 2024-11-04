//
//  CardView.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 21.10.2024.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var vm: ViewModel
    let country: CountryChart
    let width: CGFloat
    let height: CGFloat
    let imageHeight: CGFloat


    var body: some View {
        NavigationLink {
            AlbumView(country: country)
        } label: {
            CardLabel(imageName: country.image, width: width, height: height, imageHeight: imageHeight,
                      countryTitle: country.title)
            .overlay(alignment: .topTrailing) {
                if !vm.proSubscriptionBought {
                    if country.isPremium {
                        ProButtonView(title: nil)
                            .padding(8)
                    }
                }
            }
        }
    }
}

#Preview {
    MainTabView()
     .environmentObject(ViewModel())
     .environmentObject(MusicManager())
     .environmentObject(VideosManager())
}
