//
//  DotsNavigationView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 13.09.2024.
//

import SwiftUI

struct DotsNavigationView: View {
    let number: Int
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "circle.fill")
            .foregroundStyle(number == 1 ? .white : .gray)
            Image(systemName: "circle.fill")
            .foregroundStyle(number == 2 ? .white : .gray)
            Image(systemName: "circle.fill")
            .foregroundStyle(number == 3 ? .white : .gray)
            Image(systemName: "circle.fill")
            .foregroundStyle(number == 4 ? .white : .gray)
            Image(systemName: "circle.fill")
            .foregroundStyle(number == 5 ? .white : .gray)
        }
        .font(.system(size: 8))
        .padding(8)
    }
}

#Preview {
    DotsNavigationView(number: 2)
}
