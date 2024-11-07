//
//  MainView.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 16.10.2024.
//

import SwiftUI
import TipKit

struct MainView: View {
    @EnvironmentObject var vm: ViewModel
    @State var showDownloading = false
    @State var link = ""
    @State var showInstruction = false
    @FocusState private var focusedField: Field?
    let saveTip = SaveTip()
    @AppStorage("firstRun") var firstRun = true
    @Environment(\.requestReview) var requestReview

    var body: some View {
        NavigationStack(path: $vm.path) {
            ZStack {
                BackgroundMainView()
                if vm.showReviewRequest {
                Color.clear
                            .onAppear {

                                    requestReview()
                                    firstRun = false
                                vm.showReviewRequest = false
                                }
                            }


                VStack {
                    Spacer()
                    TitleMainView()
                        .overlay {
                            if vm.showVPNLinkAlert {
                                WrongLinkAllert()
                            }
                        }
                    LinkFieldMainView(link: $link)
//                        .focused($focusedField, equals: .link)
//                        .popoverTip(saveTip, arrowEdge: .bottom)
//                        .onTapGesture {
//                            saveTip.invalidate(reason: .actionPerformed)
//                        }
//                        .tipViewStyle(CustomTipViewStyle())
                    CapsuleButton(title: "Find", rightIcon: "arrow.forward") {
                        vm.findButtonPushed(link: link)
                        showDownloading = true
                    }
                    .disabled(link.isEmpty)
                    .opacity(link.isEmpty ? 0.5 : 1)
                    ShowInstructionsButton(showInstruction: $showInstruction)
                    Spacer()
                    Spacer()
                }
                .padding()
//                .onTapGesture {
//                    if (focusedField != nil) {
//                        focusedField = nil
//                    }
//                }
                if showDownloading {
                    DownloadingProgressView(showDownloading: $showDownloading)
                }
            }
            .sheet(isPresented: $showInstruction) {
                Instruction(showInstruction: $showInstruction)
                    .presentationDetents([.height(480)])
            }
            .alert("Wrong link pasted", isPresented: $vm.showWrongLinkAlert) {
                Button("Close",  action: {
                    vm.showWrongLinkAlert = false
                })
                .accentColor(.accent)
                Button("Read instructions", action: {
                    showInstruction = true
                })
            } message: {
                Text("This link does not fit, enter another one or read our instructions")
            }
            .navigationDestination(for: String.self) { clipInfo in
                PreView(tiktokLink: link, clipLink: link)
            }

        }
    }
}

#Preview {
    MainTabView()
     .environmentObject(ViewModel())
     .task {
         try? Tips.resetDatastore()
         try? Tips.configure([
             .datastoreLocation(.applicationDefault)
         ])
     }
}
