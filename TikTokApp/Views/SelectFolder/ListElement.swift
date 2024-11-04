//
//  ListElement.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 18.10.2024.
//

import SwiftUI

struct ListElement: View {
    @EnvironmentObject var vm: ViewModel
    let folderName: String
    @Binding var selectedFolder: String?
    @State var folderIsChoosen: Bool = false

    var body: some View {
        HStack {
            CircleButton(isChosen: $folderIsChoosen, action: {
                if folderIsChoosen {
                    selectedFolder = folderName
                }
            })
            Image(systemName: "bookmark")
                .foregroundStyle(.accent)
            Text(folderName)
            Spacer()
            if folderName != "Saved" {
                EllipsisButton(folderName: folderName)
            }
        }
    }
}

#Preview {
    ListElement(folderName: "Savd", selectedFolder: .constant(""))
        .environmentObject(ViewModel())
}
