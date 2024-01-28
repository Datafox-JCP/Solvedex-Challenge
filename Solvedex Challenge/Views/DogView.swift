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
    
        // MARK: View
    var body: some View {
        NavigationStack {
            /// Select the number of images to retrieve
            Stepper(value: $dogsViewModel.numberOfImages, in: 5...20) {
                Text("Images to retrieve: \(dogsViewModel.numberOfImages)")
            }
            .onChange(of: dogsViewModel.numberOfImages) {
                dogsViewModel.refresh()
            }
            .padding(.horizontal)
            
            if dogsViewModel.imageUrlList == nil {
                /// Used when not content
                ContentUnavailableView(
                    "Not possible to show images",
                    systemImage: "exclamationmark.icloud"
                )
            } else {
                List(dogsViewModel.imageUrlList!, id: \.self) { imageUrl in
                   DogRow(imageUrl: imageUrl)
                        .listRowSeparator(.hidden)
                } // List
                .listStyle(.grouped)
                .refreshable {
                    dogsViewModel.refresh()
                } // Refresh list
                .navigationTitle("Pug")
                .navigationBarTitleDisplayMode(.inline)
                /// Refresh (some people does not know pull to refresh)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            dogsViewModel.refresh()
                        } label: {
                            Image(systemName: "arrow.clockwise")
                        }
                    }
                }
            } // Is data?
        } // Navigation
        .task {
            dogsViewModel.getBreedImageList()
        } // Get images
    }
}

// MARK: - Preview
#Preview {
    DogView()
}
