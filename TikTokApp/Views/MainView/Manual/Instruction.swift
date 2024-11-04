//
//  Manual.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 17.10.2024.
//

import SwiftUI

struct Instruction: View {
    @State var page: Int = 1 {
        didSet {
            if page > 4 {
                showInstruction = false
            }
        }
    }
    @Binding var showInstruction: Bool

    var body: some View {
        VStack {
            HStack {
                Text("Instruction")
                    .font(.title3)
                    .bold()
                Spacer()
                SmallImageButton(leftIcon: "xmark",foregroundStyle: .white) {
                    showInstruction = false
                }
                
            }
            .padding()
            TabView(selection: $page) {
                InstructionTemplate(image: "first", title: "First step", text: "Open “TikTok” and find TikTok video or photo", page: $page)
                    .tag(1)
                InstructionTemplate(image: "second", title: "Second step", text: "Tap on share icon at right side", page: $page)
                    .tag(2)
                InstructionTemplate(image: "third", title: "Third step", text: "Tap on “Copy link” icon", page: $page)
                    .tag(3)
                FourthSlide(image: "forth", title: "Fourth step", text: "Open our app and paste the link", showInstruction: $showInstruction)
                    .tag(4)
            }
            .tabViewStyle(.page)
        }
        .background(.tertiary)
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
