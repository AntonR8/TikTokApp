//
//  TrendsView.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 16.10.2024.
//

import SwiftUI

struct TrendsView: View {
    @EnvironmentObject var vm: ViewModel

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(vm.trendsMusic) {section in
                    TrendsSection(section: section)
                }
            }
        }
        .padding()
    }
}

#Preview {
    MainTabView()
     .environmentObject(ViewModel())
}
