//
//  SmallRecentsFolderLabel.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 14.11.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct SmallRecentsFolderLabel: View {
    let number: Int
    let imagecornerRadius: CGFloat
    let folderSize: CGFloat
    let recentsFolderCount: Int
    let recentsFourclips: [ClipInfoModel]

    var body: some View {





        RoundedRectangle(cornerRadius: imagecornerRadius)
            .fill(.gray.opacity(0.1))
            .frame(width: folderSize/2-16, height: folderSize/2-16)
            .overlay {
                if recentsFolderCount > number {
                    if let currentURL = URL(string: recentsFourclips[number].videoPreview) {
                        WebImage(url: currentURL) { image in
                            image.resizable()
                        } placeholder: {
                            Rectangle().foregroundColor(.gray.opacity(0.1))
                        }
                        .indicator(.activity)
                        .scaledToFill()
                        .frame(width: folderSize/2-16, height: folderSize/2-16)
                        .clipShape(RoundedRectangle(cornerRadius: imagecornerRadius))
                        
                    }
                }
            }
    }
}

#Preview {
    SmallRecentsFolderLabel(number: 1, imagecornerRadius: 8, folderSize: UIScreen.main.bounds.width/2 - 24, recentsFolderCount: 1, recentsFourclips: [ClipInfoModel(
        username: "e.karepanov", 
        name: "Евгений Карепанов",
        avatar: "https://p16-sign-sg.tiktokcdn.com/tos-alisg-avt-0068/b073d1121ab837c7fa40907764b41492~tplv-tiktokx-cropcenter:300:300.jpeg?dr=14577&nonce=38148&refresh_token=b29fd14d23a5111ce3c5ae2e336cff4c&x-expires=1731657600&x-signature=IjexnYNPABx2uhZZz0j%2FFWehyVA%3D&idc=maliva&ps=13740610&shcp=d05b14bd&shp=45126217&t=4d5b0474",
        videoPreview: "https://p16-sign-sg.tiktokcdn.com/tos-alisg-p-0037/c975424cc6484cc9a94cf184f371b144_1600024896~tplv-tiktokx-360p.jpeg?dr=14555&nonce=44959&refresh_token=891e224b20e85818adae97bc43b704eb&x-expires=1731657600&x-signature=rvDlkqFDY1Kk7nr1BqEQwCRgK1o%3D&ftpl=1&idc=maliva&ps=13740610&s=AWEME_DETAIL&shcp=34ff8df6&shp=d05b14bd&t=4d5b0474",
        description: "Звуки природы . Релакс видео .#рассвет #природа #релакс #красота #солнышко #лето #вятка",
        musicTitle: "original sound - e.karepanov",
        musicUrl: "https://sf16-ies-music-sg.tiktokcdn.com/obj/tiktok-obj/6872054520516496129.mp3"
    )])
}

