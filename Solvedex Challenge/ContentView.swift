//
//  ContentView.swift
//  Solvedex Challenge
//
//  Created by Juan Hernandez Pazos on 23/01/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Image(.pug1)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 400)
                    .foregroundStyle(.tint)
                
                Image(systemName: "heart")
                    .foregroundStyle(.red)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                Text("13 Likes")
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
            }
            .padding(.all, 0)
            .navigationTitle("Pugs")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
