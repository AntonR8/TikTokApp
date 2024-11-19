//
//  LinkFieldOverlay.swift
//  SaveVideo
//
//  Created by Антон Разгуляев on 02.11.2024.
//

import SwiftUI

struct LinkFieldOverlay: View {
    @Binding var link: String

    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
            if link.isEmpty {
                Text("https://vm.tiktok.com/...")
                    .accentColor(.gray)
                    .foregroundStyle(.gray)
                    .allowsHitTesting(false)
            }
            Spacer()
            if link.isEmpty {
                PasteButton(payloadType: String.self) { strings in
                    guard let string = strings.first else {
                        return
                    }
                    self.link = String(string)
                }
                .tint(.black.opacity(0.1))
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.clear)
                        .stroke(.white, lineWidth:1)
                }
            } else {
                    XButton {
                        link = ""
                    }
            }

        }
        .padding(.horizontal, 8)
    }
}

#Preview {
    ZStack {
        Color.gray
        LinkFieldOverlay(link: .constant(""))
    }
}
