//
//  PlaylistLabel.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 01.11.2024.
//

import SwiftUI

struct PlaylistLabel: View {
    @EnvironmentObject var vm: ViewModel
    let country: CountryChart
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        AsyncImage(url: URL(string: country.image)) { image in
            if let image = image.image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
            } else {
                ProgressView()
                    .frame(width: width, height: height)
                    .background(Color.gray.opacity(0.2))
            }
        }
        .clipped()
        .cornerRadius(25)
    }
}


#Preview {
    MainTabView()
        .environmentObject(ViewModel())
        .environmentObject(VideosManager())
        .environmentObject(MusicManager())
}
