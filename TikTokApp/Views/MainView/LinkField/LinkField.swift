//
//  LinkField.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 16.10.2024.
//

import SwiftUI

struct LinkField: View {
    @Binding var link: String
    
    var body: some View {
        TextField("", text: $link)
            .padding(13.7)
            .padding(.leading, 30)
            .padding(.trailing, 30)
            .background(.white.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay {
                LinkFieldOverlay(link: $link)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 14)
                    .stroke((link.isEmpty ? Color.secondary : Color.accent), lineWidth: link.isEmpty ? 0.3 : 1)
            }
            .padding(1)
//            .truncationMode(.tail)
    }
}

#Preview {
    LinkField(link: .constant(""))
}
