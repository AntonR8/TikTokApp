//
//  GridElementView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 12.09.2024.
//

import SwiftUI

struct AsyncImageGridElementView: View {
    let imageURL: String
    let spacing: CGFloat = 20

    var body: some View {
        NavigationLink(destination: {
            AsyncImageView(imageURL: imageURL)
        }, label: {
            AsyncImage(url: URL(string: imageURL)) { image in
                if let image = image.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width/2-spacing,  height: UIScreen.main.bounds.width/2-spacing)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                } else {
                    ProgressView()
                        .frame(height: UIScreen.main.bounds.width/2-spacing)
                }
            }

            .background(
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .fill(.gray.opacity(0.2))
                    .frame(width: UIScreen.main.bounds.width/2-spacing,  height: UIScreen.main.bounds.width/2-spacing)
            )

        })

    }
}



#Preview {
    NavigationStack {
        ScrollView(showsIndicators: false) {
            AsyncImageGridView(arrayOfImages: [
                "https://cdn.apiframe.pro/images/60939684700419000315231972254360-1.png", "https://cdn.apiframe.pro/images/60939684700419000315231972254360-2.png", "https://cdn.apiframe.pro/images/60939684700419000315231972254360-3.png", "https://cdn.apiframe.pro/images/60939684700419000315231972254360-4.png"
            ])
        }
    }
}
