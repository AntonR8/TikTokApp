//
//  DetailsBanner.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 13.09.2024.
//

import SwiftUI

struct DetailsBanner: View {
    let title: String
    let description: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(description)
                .font(.title3)
                .padding(.top, 1)
        }
        .padding()
        .background(.tertiary.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    DetailsBanner(title: "Image size", description: "1024 x 1024")
}
