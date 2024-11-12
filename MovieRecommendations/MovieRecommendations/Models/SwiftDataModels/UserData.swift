//
//  UserData.swift
//  MovieRecommendations
//
//  Created by JAVIER DAVILA RUIZ on 12/11/24.
//

import Foundation
import SwiftData

@Model
class UserData {
    @Attribute(.unique) var id: UUID = UUID()  // Automatically generates a unique UUID
    var username: String
    var ratedMovies: [UserRating] = []

    init(username: String) {
        self.username = username
    }

    var moviesWatched: [MoviesWatched] {
        return ratedMovies.map { userRating in
            MoviesWatched(movieID: userRating.movieId, rating: userRating.userRating)
        }
    }
}
