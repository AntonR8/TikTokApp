//
//  LaunchScreenView.swift
//  EffectiveMobileToDoList
//
//  Created by Антон Разгуляев on 30.08.2024.
//

import SwiftUI
import AppTrackingTransparency
import StoreKit

struct LaunchScreen: View {
    @EnvironmentObject var vm: ViewModel
    @State var movement = false
    @State var size: CGFloat = 50

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Text("")
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        withAnimation(.linear(duration: 1)) {
                            movement = true
                        }
                    }
                }

            if movement {
                Image("appicon")
                    .resizable()
                    .frame(width: size, height: size)
                    .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)) 
                    .shadow(color: .black, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 5, y: 5)
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                            withAnimation {
                                size = 150
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                            movement = false
                            vm.launchScreenOpacity = 0
                        }
                    }
            }
        }
    }


}

#Preview {
    LaunchScreen()
        .environmentObject(ViewModel())
}
