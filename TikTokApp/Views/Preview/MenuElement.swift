






import SwiftUI

struct MenuElement: View {
    let icon: String
    let title: String
    var body: some View {
        VStack {
            Circle()
                .fill(.clear)
                .stroke(.secondary, lineWidth: 1)
                .frame(width: 52)
                .overlay {
                    Image(systemName: icon)
                }
            Text(title)
                .font(.caption2)
                .frame(width: 76)
                .multilineTextAlignment(.center)
        }
    }
}


























//#Preview {
//    NavigationStack {
//        PreView(clipInfo: ClipInfoData(
//                username: "e.karepanov",
//                name: "Евгений Карепанов",
//                avatar: "https://p16-sign-sg.tiktokcdn.com/aweme/100x100/tos-alisg-avt-0068/b073d1121ab837c7fa40907764b41492.jpeg?lk3s=a5d48078&amp;nonce=38857&amp;refresh_token=9167de90b385af000289cbda4f4997e5&amp;x-expires=1729695600&amp;x-signature=QzOLiiMOMcqBvWvfaiU6BDgW0%2FE%3D&amp;shp=a5d48078&amp;shcp=81f88b70",
//                videoPreview: "https://p16-sign-sg.tiktokcdn.com/obj/tos-alisg-p-0037/c975424cc6484cc9a94cf184f371b144_1600024896?lk3s=81f88b70&amp;x-expires=1729695600&amp;x-signature=geWvxbhqtLugx4KTKoi9fqWVke0%3D&amp;shp=81f88b70&amp;shcp=-",
//                description: "Звуки природы . Релакс видео .",
//                musicTitle: "оригинальный звук - Евгений Карепанов",
//                musicURL: "https://www.tiktok.com/music/оригинальный-звук-6872054574136789761"), postRequestResponse: nil, clipLink: "https://www.tiktok.com/music/оригинальный-звук-6872054574136789761")
//    }
//}

