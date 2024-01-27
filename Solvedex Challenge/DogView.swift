    //
    //  DogView.swift
    //  Solvedex Challenge
    //
    //  Created by Juan Hernandez Pazos on 23/01/24.
    //

import SwiftUI

struct DogView: View {
    
    // MARK: Properties
    @ObservedObject var dogsViewModel = DogsViewModel()
    
    @State private var heartTapped = false
    
        // MARK: View
    var body: some View {
        NavigationStack {
            if dogsViewModel.imageUrlList == nil {
                if dogsViewModel.isLoading {
                    LoaderView()
                }
            }
                // Else it contains URLs, so load each of those
            else {
                List(dogsViewModel.imageUrlList!, id: \.self) { imageUrl in
                    VStack(alignment: .leading) {
                        AsyncImage(url: URL(string: imageUrl)) { phase in
                            switch phase {
                            case .empty:
                                Color.purple.opacity(0.1)
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
                                heartTapped.toggle()
                            }
                        
                        Text("13 Likes")
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                    } // VStack
                    .padding(.all, 0)
                } // List
                .listStyle(PlainListStyle())
                .refreshable {
                    dogsViewModel.refresh()
                }
                .navigationTitle("Pug")
                .navigationBarTitleDisplayMode(.inline)
            } // Validation
            
            if dogsViewModel.isLoading {
                LoaderView()
            }
        } // Navigation
        .task {
            dogsViewModel.getImageList()
        }
        .alert(isPresented: $dogsViewModel.shouldShowAlert) {
            return Alert(
                title: Text("Error"),
                message: Text(dogsViewModel.dogError?.errorDescription ?? "")
            )
        } // Alert
    }
}

    //#Preview {
    //    DogView())
    //}
