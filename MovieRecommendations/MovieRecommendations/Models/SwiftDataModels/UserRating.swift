//
//  UserRating.swift
//  MovieRecommendations
//
//  Created by JAVIER DAVILA RUIZ on 12/11/24.
//
import Foundation
import SwiftData

@Model
class UserRating {
    @Attribute(.unique) var id: UUID = UUID()
    var movieId: Int
    var userRating: Double
    var review: String?
    var user: UserData?  // Link back to RealUser for the one-to-many relationship

    init(movieId: Int, userRating: Double, review: String? = nil, user: UserData) {
        self.movieId = movieId
        self.userRating = userRating
        self.review = review
        self.user = user
    }
}
