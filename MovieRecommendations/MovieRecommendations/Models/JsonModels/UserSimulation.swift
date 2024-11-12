//
//  UserSimulation.swift
//  MovieRecommendations
//
//  Created by JAVIER DAVILA RUIZ on 12/11/24.
//

import Foundation

// MARK: - UserSimulationElement
class UserSimulationElement: Codable {
    var id: Int  // Unique ID
    let username: String
    let moviesWatched: [MoviesWatched]

    init(id: Int, username: String, moviesWatched: [MoviesWatched]) {
        self.id = id
        self.username = username
        self.moviesWatched = moviesWatched
    }
}

// MARK: - MoviesWatched
class MoviesWatched: Codable {
    let movieID: Int
    let rating: Double

    enum CodingKeys: String, CodingKey {
        case movieID = "movieId"
        case rating
    }

    init(movieID: Int, rating: Double) {
        self.movieID = movieID
        self.rating = rating
    }
}

typealias UserSimulation = [UserSimulationElement]
