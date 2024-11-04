//
//  BestOfferBadgeView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 27.09.2024.
//

import SwiftUI

struct BestOfferBadgeView: View {
    var body: some View {
        Text("SAVE 83%")
            .font(.caption2)
            .bold()
            .padding(4)
            .padding(.horizontal, 2)
            .foregroundStyle(.black)
            .background(
                Capsule()
                    .foregroundStyle(Color.electric)
        )
    }
}

#Preview {
    BestOfferBadgeView()
}
