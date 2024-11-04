//
//  CoverView.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 23.10.2024.
//

import SwiftUI

struct CoverView: View {
    @Binding var showAddedToSavedAlert: Bool
    let country: CountryChart

    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: country.image)) { image in
                if let image = image.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else {
                    ProgressView()
                }
            }

            VStack {
                if showAddedToSavedAlert {
                    CapsuleNotification(iconName: "checkmark.circle.fill", message: "Added to “saved” tab")
                        .padding(.top, 80)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation(.easeInOut) {
                                    showAddedToSavedAlert = false
                                }
                            }
                        }

            }
                Spacer()
                Text(country.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("Top trends for TikTok")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            .padding()
        }
        .frame(height: 390)
        Spacer()
    }
}

#Preview {
    MainTabView()
     .environmentObject(ViewModel())
}
