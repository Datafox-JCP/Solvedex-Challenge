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
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: imageUrl)) { phase in
                switch phase {
                case .empty:
                    Color.blue.opacity(0.2)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure(_):
                    Image(systemName: "exclamationmark.icloud")
                        .resizable()
                        .scaledToFit()
                @unknown default:
                    Image(systemName: "exclamationmark.icloud")
                } // Phase
            } // AsyncImage
            .frame(maxWidth: .infinity, maxHeight: 500)
            
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
            
            Text("\(likes) Likes")
                .padding(.horizontal, 16)
                .padding(.top, 16)
        } // VStack
    }
}

// MARK: - Preview
#Preview {
    DogRow()
}
