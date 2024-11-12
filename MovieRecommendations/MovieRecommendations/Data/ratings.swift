//
//  ratings.swift
//  MovieRecommendations
//
//  Created by Jimena Gallegos on 12/11/24.
//

import Foundation

struct RatingSet {
    static let javier: [String: Double] = [
        "Toy Story (1995)": 5.0,
        "Star Wars: Episode IV - A New Hope (1997)": 4.0
    ]
    
    static let danna: [String: Double] = [
        "The Matrix (1999)": 5.0,
        "The Godfather (1972)": 4.5
    ]
    
    static let gigi: [String: Double] = [
        "The Dark Knight (2008)": 4.8,
        "Inception (2010)": 4.9
    ]
    
    static func combineSets(sets: [[String: Double]]) -> [String: Double] {
        var combinedRatings = [String: [Double]]()
        
        for set in sets {
            for (movie, rating) in set {
                if combinedRatings[movie] != nil {
                    combinedRatings[movie]?.append(rating)
                } else {
                    combinedRatings[movie] = [rating]
                }
            }
        }
        
        var averagedRatings = [String: Double]()
        for (movie, ratings) in combinedRatings {
            let averageRating = ratings.reduce(0, +) / Double(ratings.count)
            averagedRatings[movie] = averageRating
        }
        
        return averagedRatings
    }
}
