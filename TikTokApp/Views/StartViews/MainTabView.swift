//
//  ContentView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 12.09.2024.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var videosManager: VideosManager
    @EnvironmentObject var musicManager: MusicManager
    @State var path: [String] = []
    @State var showFolders: Bool = false

    var body: some View {
        NavigationStack(path: $vm.path) {

            TabView(selection: $vm.tabSelection,
                    content: {
                Group {
                    MainView()
                        .tabItem {
                            Image(systemName: "square.and.arrow.down.fill")
                            Text("Main")
                        }.tag(1)
                    SavedView()
                        .tabItem {
                            Text("Saved")
                            Image(systemName: "bookmark")
                        }.tag(2)
                    TrendsView()
                        .tabItem {
                            Text("Trends")
                            Image(systemName: "music.note.list")
                        }.tag(3)
                    SettingsView()
                        .tabItem {
                            Text("Settings")
                            Image(systemName: "gear")
                        }.tag(4)
                }
                .toolbarBackground(.black, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
            })
            .toolbar {
                if !vm.proSubscriptionBought {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            vm.showPaywall = true
                        } label: {
                            ProButtonView()
                        }
                    }
                }
                if vm.tabSelection == 2 {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            if vm.savedViewSelection == "Videos" {
                                vm.selectedType = "Videos"
                                vm.showCreateVideosFolderAllert = true
                            } else {
                                vm.selectedType = "Music"
                                vm.showCreateMusicFolderAllert = true
                            }
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
             .navigationTitle(vm.returnNavigationTitle())
            .fullScreenCover(isPresented: $vm.showPaywall) {
                PaywallView()
            }

        }
        .preferredColorScheme(.dark)
        .accentColor(vm.albumViewIsShowing ? .white : .accentColor)
    }
}

#Preview {
    MainTabView()
        .environmentObject(ViewModel())
        .environmentObject(VideosManager())
        .environmentObject(MusicManager())
}
