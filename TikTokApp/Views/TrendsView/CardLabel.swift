//
//  CardLabel.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 01.11.2024.
//

import SwiftUI

struct CardLabel: View {
    let imageName: String
    let width: CGFloat
    let height: CGFloat
    let imageHeight: CGFloat
    let countryTitle: String

    var body: some View {
        AsyncImage(url: URL(string: imageName)) { image in
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
            .overlay {
                VStack{
                    Color.clear
                        .frame(height: imageHeight)
                    ZStack {
                        Color.black
                        Color.gray.opacity(0.2)
                        Text(countryTitle)
                            .foregroundStyle(.white)
                            .padding(.bottom, 16)
                    }
                }
            }

            .clipped()
            .cornerRadius(25)
    }
}

#Preview {
    ZStack {
        Color.red
        CardLabel(imageName: "",
                  width: UIScreen.main.bounds.width/2-24,
                  height: 202.4,
                  imageHeight: 138.4,
                  countryTitle: "Россия")
    }
}

//https://media-backend.finanse.space/storage/setImages/r3PPAWiAaVxMfmzXVYTpOEbWxf3USRzf3g9W8umY.webp
