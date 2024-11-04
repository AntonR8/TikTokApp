//
//  videoPreview.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 17.10.2024.
//

import SwiftUI

struct VideoPreview: View {
    let info: ClipInfoModel
    let clipLink: String

    var body: some View {
        Link(destination: URL(string: clipLink)!) {
            AsyncImage(url: URL(string: info.videoPreview)) { image in
                if let image = image.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                } else {
                    ProgressView()
                }
            }
        }
        .overlay(alignment: .bottom) {
                ClipInfo(info: info)
                    .padding(.bottom)
                    .padding(.leading, 8)
        }
        .overlay {
                Link(destination: URL(string: clipLink)!) {
                    Image(systemName: "play.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.gray)
                        .clipShape(Circle())
            }
        }
        .padding(32)
    }
}
