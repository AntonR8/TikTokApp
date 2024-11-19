//
//  AppVersionView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 10.10.2024.
//

import SwiftUI

struct AppVersionView: View {

    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

    var body: some View {
        Section {
            HStack {
                Spacer()
                Text("App Version: \(appVersion ?? "1.1")")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding(.top, -25) 
            .listRowBackground(Color.clear)
        }
    }
}

#Preview {
    AppVersionView()
}
