//
//  RecomendationsView.swift
//  MovieRecommendations
//
//  Created by Jimena Gallegos on 13/11/24.
//

import SwiftUI

struct RecomendationsView: View {
    var movies: [MovieS]
    var body: some View {
        VStack {
            List(movies) { movie in
                VStack(alignment: .leading) {
                    Text(movie.name)
                    Text("\(movie.score, specifier: "%.2f")")
                        .font(.system(size: 14))
                        .foregroundColor(Color.gray)
                }
            }
            .navigationTitle("Películas Recomendadas")
        }
    }
}

#Preview {
    RecomendationsView(movies: [
        MovieS(name: "Inception", score: 4.5, movieGenre: ["Animation"]),
           MovieS(name: "The Matrix", score: 4.7, movieGenre: ["Animation"]),
           MovieS(name: "Toy Story", score: 4.3, movieGenre: ["Animation"])
       ])
}
