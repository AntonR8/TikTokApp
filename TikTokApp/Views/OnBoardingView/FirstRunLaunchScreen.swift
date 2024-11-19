//
//  LaunchAndATTScreen.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 13.11.2024.
//

import SwiftUI
import AppTrackingTransparency

struct FirstRunLaunchScreen: View {
    @State var path: [Int] = []
    @State var movement = false
    @State var size: CGFloat = 50
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
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
                                    allowATT()
                            }
                        }
                }
            }
                .navigationDestination(for: Int.self, destination: { _ in FirstView() } )
        }
    }

    func allowATT() {
        ATTrackingManager.requestTrackingAuthorization { status in
            switch status {
            case .authorized:
                print("Tracking Authorized")
                DispatchQueue.main.async{
                    path.append(1)
                }
            case .denied:
                print("Tracking Denied")
                DispatchQueue.main.async{
                    path.append(1)
                }
            case .notDetermined:
                print("Tracking Not Determined")
                DispatchQueue.main.asyncAfter(deadline: .now()+10) {
                    path.append(1)
                    }
            case .restricted:
                print("Tracking Restricted")
                        DispatchQueue.main.async{
                            path.append(1)
                        }
            @unknown default:
                print("Tracking Unknown")
                            DispatchQueue.main.async{
                                path.append(1)
                            }
            }
        }
    }

}

#Preview {
    FirstRunLaunchScreen()
}
