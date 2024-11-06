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
    @State var endLaunch: Bool = false

    @Environment(\.requestReview) var requestReview

    func allowATT() {
        ATTrackingManager.requestTrackingAuthorization { status in
            switch status {
            case .authorized:
                print("Tracking Authorized")
                movement = false
//                print(ASIdentifierManager.shared().advertisingIdentifier)
            case .denied:
                print("Tracking Denied")
                movement = false
            case .notDetermined:
                print("Tracking Not Determined")
                movement = false
            case .restricted:
                print("Tracking Restricted")
                movement = false
            @unknown default:
                print("Tracking Unknown")
                movement = false
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
                            if firstRun {
                                allowATT()
                            }
                        }
                    }
                    .onDisappear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            if firstRun {
                                requestReview()
                            }
                            endLaunch = true
                        }
                    }
            }
            if endLaunch {
                Button {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        vm.launchScreenOpacity = 0
                    }
                } label: {
                    LinearGradient(colors: [Color.launchscreen1, Color.launchscreen2], startPoint: .bottom, endPoint: .top)
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
