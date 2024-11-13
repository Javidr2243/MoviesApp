//
//  MovieListView.swift
//  MovieRecommendations
//
//  Created by JAVIER DAVILA RUIZ on 13/11/24.
//

import SwiftUI

struct MovieListView: View {
    var body: some View {
        NavigationView { // Agregar NavigationView aquí
            MovieSearchView()
        }
    }
}

// Previews
#Preview {
    MovieListView()
}
