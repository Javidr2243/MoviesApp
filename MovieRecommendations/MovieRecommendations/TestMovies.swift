//
//  TestMovies.swift
//  MovieRecommendations
//
//  Created by JAVIER DAVILA RUIZ on 12/11/24.
//

import SwiftUI

struct TestMovies: View {
    var movies: [MovieElement]  // Accepts movie data as a parameter

    var body: some View {
        List(movies, id: \.movieID) { movie in
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                Text(movie.genres)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("Movies")
    }
}

// Preview
#Preview {
    TestMovies(movies: movieData)
}
