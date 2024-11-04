//
//  Tips.swift
//  AIImageGenerator
//
//  Created by АнтохаПрограммист on 14.09.2024.
//

import Foundation
import TipKit


struct SaveTip: Tip {
    var title: Text {
        Text("Sorry, this link is not supported, please insert another one")
    }
}

struct CustomTipViewStyle: TipViewStyle {
    func makeBody(configuration: TipViewStyle.Configuration) -> some View {
        configuration.title?
            .font(.subheadline)
            .multilineTextAlignment(.center)
            .foregroundStyle(.white)

            .padding()
            .background(.accent)
    }
}
