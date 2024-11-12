//
//  MovieRecommenderSwift.swift
//  MovieRecommendations
//
//  Created by Jimena Gallegos on 12/11/24.
//
import SwiftUI
import CoreML

public class Recommender: ObservableObject {
    
    @Published var movies = [MovieS]()
    
    func load(ratings: [String: Double]) {
            do {
                let recommender = MovieRecommender()
                let input = MovieRecommenderInput(items: ratings, k: 5, restrict_: [], exclude: [])
                
                let result = try recommender.prediction(input: input)
                var tempMovies = [MovieS]()
                
                for str in result.recommendations {
                    let score = result.scores[str] ?? 0
                    tempMovies.append(MovieS(name: "\(str)", score: score))
                }
                self.movies = tempMovies
                
            } catch {
                print("Error in prediction: \(error.localizedDescription)")
        }
    }
        
}

struct MovieS: Identifiable {
public var id = UUID()
public var name: String
public var score: Double
}
