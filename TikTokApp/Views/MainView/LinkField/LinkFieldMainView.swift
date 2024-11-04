//
//  LinkFieldMainView.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 28.10.2024.
//

import SwiftUI

enum Field: Int {
    case link
}

struct LinkFieldMainView: View {
 
    @Binding var link: String

    var body: some View {
        LinkField(link: $link)

            .scrollDismissesKeyboard(.immediately)
//            .onTapGesture {
//                if (focusedField != nil) {
//                    focusedField = nil
//                }
//            }
            .padding(.vertical, 8)
    }
}

#Preview {
    LinkFieldMainView(link: .constant(""))
}
