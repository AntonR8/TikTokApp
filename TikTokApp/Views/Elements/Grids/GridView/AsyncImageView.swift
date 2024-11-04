//
//  AIImageView.swift
//  AIImageGenerator
//
//  Created by Антон Разгуляев on 13.09.2024.
//

import SwiftUI

struct AsyncImageView: View {
    @EnvironmentObject var vm: ViewModel

    @State var showInfos = false
    @State var showSavedToGallery = false
    @State var showPromptCopied = false
    @State var showAddedToFavourites = false
    @State var savedToFavourites = false

    let imageURL: String
//    let saveTip = SaveTip()

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                image
                promptTitle
                promptDescription
                infos
                titleForGrid
//                HardCodeGridView(arrayOfImages: vm.hardCodeImages)
            }
        }
        .padding(.horizontal)

    }
}


#Preview {
    AsyncImageView(imageURL: "")
        .environmentObject(ViewModel())
}


extension AsyncImageView {
    var image: some View {
        ZStack {
            AsyncImage(url: URL(string: imageURL)) { image in
                if let image = image.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                } else {
                    ProgressView()
                        .frame(height: UIScreen.main.bounds.width-32)
                }
            }
               
            VStack {
                HStack {
                    Button(action: {
                        Task {
//                            await vm.saveAsyncImageToGallery(imageURL: imageURL)
                            await MainActor.run {
                                withAnimation(.easeInOut) {
                                    showSavedToGallery = true
                                }
                            }
                        }
                    }, label: {
                        SmallImageButton(leftIcon: "arrow.down.to.line", foregroundStyle: .white, action: {})
                    })
//                    .popoverTip(saveTip)
                    .onTapGesture {
//                        saveTip.invalidate(reason: .actionPerformed)
                    }
//                    .tipViewStyle(CustomTipViewStyle())
                    Spacer()

                    AsyncImage(url: URL(string: imageURL)) { image in
                        if let image = image.image {
                            ShareLink(item: image, preview: SharePreview("image", image: image)) {
                                SmallImageButton(leftIcon: "square.and.arrow.up", foregroundStyle: .white, action: {})
                            }
                        }
                    }
                    
                    Button(action: {
//                        vm.addToFavourites(imageURL: imageURL)
                        withAnimation(.easeInOut) {
                            showAddedToFavourites = true
                            savedToFavourites = true
                        }
                    }, label: {
                        SmallImageButton(leftIcon: "heart", foregroundStyle: savedToFavourites ? .red : .white.opacity(0.5), action: {})
                    })
                }
                .padding(8)
                Spacer()
            }
            if showSavedToGallery {
                VStack {
                    CapsuleNotification(iconName: "checkmark.circle.fill", message: "Take a photo")
                        .offset(y: -14)
                    Spacer()
                }
                .onAppear(perform: {
                    withAnimation(.easeInOut) {
                        DispatchQueue.main.asyncAfter(deadline: .now()+5, execute: {showSavedToGallery = false})
                    }
                    })
            }
            if showPromptCopied {
                VStack {
                    CapsuleNotification(iconName: "checkmark.circle.fill", message: "Prompt copied")
                        .offset(y: -14)
                    Spacer()
                }
                .onAppear(perform: {
                    withAnimation(.easeInOut) {
                        DispatchQueue.main.asyncAfter(deadline: .now()+5, execute: {showPromptCopied = false})
                    }
                })
            }
            if showAddedToFavourites {
                VStack {
                    CapsuleNotification(iconName: "checkmark.circle.fill", message: "Added to \"Profile\"")
                        .offset(y: -14)
                    Spacer()
                }
                .onAppear(perform: {
                    withAnimation(.easeInOut) {
                        DispatchQueue.main.asyncAfter(deadline: .now()+5, execute: {showAddedToFavourites = false})
                    }
                })
            }
        }
        .padding(.bottom)
    }

    var promptTitle: some View {
        HStack {
            Text("Prompt")
                .font(.headline)
                .foregroundStyle(.primary)

            Spacer()
            Text("Copy")
                .foregroundStyle(.secondary)
            Button(action: {
                withAnimation(.easeInOut) {
                    showPromptCopied = true
                }
            }, label: {
                Image(systemName: "doc.on.doc")
            })
        }
        .padding(.vertical)
    }


    var promptDescription: some View {
        Text("asda")
            .frame(maxWidth: .infinity)
            .padding()
            .background(.tertiary.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }

    var infos: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Infos")
                    .font(.headline)
                    .foregroundStyle(.primary)

                Spacer()
                Spacer()
                Text(showInfos ? "Collapse" : "Open")
                    .foregroundStyle(.secondary)
                Button(action: {
                    withAnimation(.bouncy) {
                        showInfos.toggle()
                    }
                }, label: {
                    Image(systemName: showInfos ? "chevron.down" : "chevron.up")
                })
            }
            if showInfos {
                Text("Details")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.top, 8)
                scrollView
            }
        }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 15.0).stroke(.tertiary, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            }
        .padding(.vertical)

    }


    var scrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                DetailsBanner(title: "Image size", description: "1024 x 1024")
//                DetailsBanner(title: "Model", description: vm.styleChosen?.rawValue ?? "None")
                DetailsBanner(title: "Aspect Ratio", description: "1:1 - landscape")
            }
        }
    }

    var titleForGrid: some View {
        Text("More images like this")
            .font(.title3)
            .bold()
            .foregroundStyle(.primary)
            .padding(.top)
    }

}
