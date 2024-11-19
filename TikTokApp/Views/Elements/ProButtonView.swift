import SwiftUI

struct ProButtonView: View {
    var title: String? = "PRO"

    var body: some View {
        HStack {
            Image(systemName: "crown.fill")
                .font(title != nil ? .caption : .headline)
            if let title {
                Text(title)
                    .bold()
            }

        }
        .padding(title != nil ? 6 : 10)
        .padding(.horizontal, title != nil ? 6 : 0)
        .padding(.horizontal, title != nil ? 0 : -2)
        .foregroundStyle(.white)
        .background(
            ZStack {
                if let title {
                    RoundedRectangle(cornerRadius: 8)
                } else {
                    Capsule()
                }
            }
                .foregroundStyle(Color.accentColor.gradient)
        )
    }
}

#Preview {
    ProButtonView(title: nil)
}
