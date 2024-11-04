//
//  AppVersionView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 10.10.2024.
//

import SwiftUI

struct AppVersionView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("App Version: 1.1.0")
                .font(.caption)
                .foregroundStyle(.secondary)
               Spacer()
        }
    }
}

#Preview {
    AppVersionView()
}
