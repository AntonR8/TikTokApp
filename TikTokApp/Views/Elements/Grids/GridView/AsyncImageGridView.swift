//
//  GridView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 12.09.2024.
//

import SwiftUI

struct AsyncImageGridView: View {
    var arrayOfImages: [String]

    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem()], content: {
            ForEach(arrayOfImages, id: \.self) { image in
                AsyncImageGridElementView(imageURL: image)
            }
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
