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
    @AppStorage("firstRun") var firstRun = true
    @State var movement = false
    @State var size: CGFloat = 50

    

    func allowATT() {
        ATTrackingManager.requestTrackingAuthorization { status in
            switch status {
            case .authorized:
                print("Tracking Authorized")
                DispatchQueue.main.async{
                    vm.launchScreenOpacity = 0
                }
            case .denied:
                print("Tracking Denied")
                DispatchQueue.main.async{
                vm.launchScreenOpacity = 0
                }
            case .notDetermined:
                print("Tracking Not Determined")
                DispatchQueue.main.asyncAfter(deadline: .now()+10) {
                    vm.launchScreenOpacity = 0
                    }
            case .restricted:
                print("Tracking Restricted")
                        DispatchQueue.main.async{
                vm.launchScreenOpacity = 0
                        }
            @unknown default:
                print("Tracking Unknown")
                            DispatchQueue.main.async{
                vm.launchScreenOpacity = 0
                            }
            }
        }
    }

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.launchscreen1, Color.launchscreen2], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
            Text("")
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        withAnimation(.linear(duration: 1)) {
                            movement = true
                        }
                    }
                }

            if movement {
                Image("logo1")
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
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now()+4) {
                            if firstRun {
                                allowATT()
                            }
                        }
                    }
            }
        }
    }


}

#Preview {
    LaunchScreen()
        .environmentObject(ViewModel())
        .environmentObject(VideosManager())
        .environmentObject(MusicManager())
}
