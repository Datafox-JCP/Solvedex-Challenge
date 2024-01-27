//
//  LoaderView.swift
//  Solvedex Challenge
//
//  Created by Juan Hernandez Pazos on 24/01/24.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        ProgressView()
            .scaleEffect(2.0, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: .black))
    }
}

#Preview {
    LoaderView()
}
