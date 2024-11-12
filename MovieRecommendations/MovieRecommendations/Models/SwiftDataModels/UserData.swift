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
    @Attribute(.unique) var id: UUID = UUID()
    var username: String
    var ratedMovies: [UserRating] = []  // One-to-many relationship with UserRating

    init(username: String) {
        self.username = username
    }
}
