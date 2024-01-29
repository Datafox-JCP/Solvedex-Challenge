//
//  DogRow.swift
//  Solvedex Challenge
//
//  Created by Juan Hernandez Pazos on 27/01/24.
//

import SwiftUI

struct DogRow: View {
    // MARK: Properties
    var imageUrl = ""
    @State var heartTapped = false
    @State var likes = 0
    @State var noImage = false

    // MARK: - View
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: imageUrl)) { phase in
                switch phase {
                case .empty:
                    /// Use progress view
                    ProgressView()
                        .tint(.accentColor)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure:
                    Image(systemName: "exclamationmark.icloud")
                        .resizable()
                        .scaledToFit()
                        .onAppear {
                            noImage = true
                        }
                @unknown default:
                    Image(systemName: "exclamationmark.icloud")
                        .resizable()
                        .scaledToFit()
                } // Phase
            } // AsyncImage
            .frame(maxWidth: .infinity, maxHeight: 500)

            /// In case no image available Heart and Likes will not show
            if !noImage {
                Image(systemName: "heart")
                    .imageScale(.large)
                    .foregroundStyle(heartTapped ? .red : .gray)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .onTapGesture {
                        if !heartTapped {
                            heartTapped = true
                            likes += 1
                        } else {
                            likes += 1
                        }
                    }

                /// Added inflect to handle plurals (1 Like / 2 Likes)
                Text("^[\(likes) Likes](inflect: true)")
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
            }
        } // VStack
    }
}

// MARK: - Preview
#Preview {
    DogRow()
}
