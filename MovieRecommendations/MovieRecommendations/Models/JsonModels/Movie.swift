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
    let imageID: Int

    enum CodingKeys: String, CodingKey {
        case movieID = "movieId"
        case title, genres
        case imageID = "image_id"
    }

    init(movieID: Int, title: String, genres: String, imageID: Int) {
        self.movieID = movieID
        self.title = title
        self.genres = genres
        self.imageID = imageID
    }
}

typealias Movie = [MovieElement]
