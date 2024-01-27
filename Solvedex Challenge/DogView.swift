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
                if dogsViewModel.isLoading {
                    LoaderView()
                } // Is loading
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
            
            if dogsViewModel.isLoading {
                LoaderView()
            }
        } // Navigation
        .task {
            dogsViewModel.getImageList()
        } // Get images task
        .alert(isPresented: $dogsViewModel.shouldShowAlert) {
            return Alert(
                title: Text("Error"),
                message: Text(dogsViewModel.dogError?.errorDescription ?? "")
            )
        } // Alert
    }
}

// MARK: - Preview
#Preview {
    DogView()
}
