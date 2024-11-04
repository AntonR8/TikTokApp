//
//  NoVideosView.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 01.11.2024.
//

import SwiftUI

struct NoVideosView: View {
    @EnvironmentObject var vm: ViewModel
    let folderName: String

    var icon: String { folderName == "Recents" ? "clock.arrow.circlepath" : "folder"}
    var title: String { folderName == "Recents" ? "No recent videos" : "No videos"}
    var description: String {folderName == "Recents" ? "Search through our search on the main TikTok video and it will show up here" : "Open any video you want and click “add...” to save it in that folder"}

    var body: some View {
        VStack {
            Spacer()
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundStyle(.secondary)
                .padding(4)
            Text(title)
                .font(.title3)
                .bold()
                .padding(8)
            Text(description)
                .font(.footnote)
                .padding(.horizontal, 50)
                .multilineTextAlignment(.center)

            if folderName == "Recents" {
                CapsuleButton(title: "Find", rightIcon: "arrow.forward") {
                    vm.tabSelection = 1
                }
                .frame(width: 200)
                .padding()
            }
            Spacer()
        }
    }
}

#Preview {
    NoVideosView(folderName: "Recents")
        .environmentObject(ViewModel())
}
