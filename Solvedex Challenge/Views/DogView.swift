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
            if dogsViewModel.imageUrlList == nil {
                
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
            } // Is loaded
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
