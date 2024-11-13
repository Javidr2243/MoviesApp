//
//  ratings.swift
//  MovieRecommendations
//
//  Created by Jimena Gallegos on 12/11/24.
//

import Foundation

struct RatingSet {
    static let Javier: [String: Double] = [
        "Toy Story (1995)": 5.0,
        "Star Wars: Episode IV - A New Hope (1997)": 4.0
    ]
    
    static let Danna: [String: Double] = [
        "Sabrina (1995)": 4.0,
        "Clueless (1995)": 4.0
    ]
    
    static let Gigi: [String: Double] = [
        "The Dark Knight (2008)": 4.8,
        "Inception (2010)": 4.9
    ]
    
    static let Jimena: [String: Double] = [
        "The Dark Knight (2008)": 4.8,
        "Inception (2010)": 4.9
    ]
    
    static let Analia: [String: Double] = [
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
    
    static func set(for name: String) -> [String: Double]? {
            switch name {
            case "Javier":
                return RatingSet.Javier
            case "Danna":
                return RatingSet.Danna
            case "Gigi":
                return RatingSet.Gigi
            case "Analia":
                return RatingSet.Analia
            case "Jimena":
                return RatingSet.Jimena
            default:
                return nil
            }
        }
}


struct MoviesGroup: Identifiable {
    let id = UUID()
    let name: String
    let persons: [String]
    let image: String
}

struct DataManager {
    static let groups: [MoviesGroup] = [
        MoviesGroup(name: "Checo y Los Perez", persons: ["Jimena", "Gigi", "Danna", "Analia", "Javier"], image:"🌮"),
        MoviesGroup(name: "Group 2", persons: ["Gigi", "Javier", "Analia"], image: "😎"),
        MoviesGroup(name: "Group 3", persons: ["Gigi", "Danna", "Analia", "Jimena"], image: "👻"),
        MoviesGroup(name: "Group 4", persons: ["Danna", "Analia", "Jimena"], image: "🍿"),
    ]
    
}

