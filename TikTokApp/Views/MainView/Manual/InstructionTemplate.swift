//
//  ManualTemplate.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 17.10.2024.
//

import SwiftUI

struct InstructionTemplate: View {
    let image: String
    let title: String
    let text: String
    @Binding var page: Int

    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 48)
            Text(title)
                .font(.title3)
                .bold()
                .padding(.top ,8)
            Text(text)
                .font(.footnote)
            CapsuleButton(leftIcon: "", title: "Next step", rightIcon: "arrow.forward", action: {
                page += 1
            })
            .padding(.top, 40)
        }
        .padding()
    }
}

#Preview {
    ZStack {
        Color.gray
        Instruction(showInstruction: .constant(true))
            .frame(height: 480)
            .background(.black)
    }
}
