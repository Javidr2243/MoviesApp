//
//  Movie.swift
//  MovieRecommendations
//
//  Created by JAVIER DAVILA RUIZ on 12/11/24.
//

import Foundation

// MARK: - MovieElement
class MovieElement: Codable {
    let movieID: Int
    let title, genres: String

    enum CodingKeys: String, CodingKey {
        case movieID = "movieId"
        case title, genres
    }

    init(movieID: Int, title: String, genres: String) {
        self.movieID = movieID
        self.title = title
        self.genres = genres
    }
}

typealias Movie = [MovieElement]
