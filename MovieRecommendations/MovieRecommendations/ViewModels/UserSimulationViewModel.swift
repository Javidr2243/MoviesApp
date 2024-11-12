//
//  UserSimulationViewModel.swift
//  MovieRecommendations
//
//  Created by JAVIER DAVILA RUIZ on 12/11/24.
//

import Foundation

class UserSimulationsViewModel: ObservableObject {
    // Published properties for movie and user simulation data
    @Published var userSimulations: [UserSimulationElement]
    @Published var movies: [MovieElement]

    init(userSimulations: [UserSimulationElement], movies: [MovieElement]) {
        self.userSimulations = userSimulations
        self.movies = movies
    }

    // Function to get the movie title by movieID
    func movieTitle(for movieID: Int) -> String {
        return movies.first(where: { $0.movieID == movieID })?.title ?? "Unknown Title"
    }
}

