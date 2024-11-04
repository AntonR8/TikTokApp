import SwiftUI

struct ClipInfo: View {
    let info: ClipInfoModel

    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: info.avatar)) { image in
                if let image = image.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36)
                        .clipShape(Circle())
                } else {
                    ProgressView()
                        .frame(height: UIScreen.main.bounds.width-32)
                }
            }

            VStack(alignment: .leading) {
                Text(info.name)
                    .font(.footnote)
                    .bold()
                Text(info.description)
                    .font(.caption2)

                HStack {
                    Image(systemName: "music.note")
                        .foregroundStyle(.electric)
                    Text(info.musicTitle)
                        .font(.caption2)
                }
                .padding(6)
                .background(Color.black.opacity(0.3))
                .cornerRadius(6)
            }
            .padding(.top, 2)

        }
    }
}
