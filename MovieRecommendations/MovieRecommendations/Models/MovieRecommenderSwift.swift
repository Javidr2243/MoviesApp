//
//  MovieRecommenderSwift.swift
//  MovieRecommendations
//
//  Created by Jimena Gallegos on 12/11/24.
//
import SwiftUI
import CoreML

struct MovieGenre: Codable {
    var movieId: Int
    var title: String
    var genres: String
}


public class Recommender: ObservableObject {
    
    @Published var movies = [MovieS]()
    
    func loadGenres() -> [MovieGenre]? {
            guard let url = Bundle.main.url(forResource: "csvjson", withExtension: "json") else {
                print("Error: file not found.")
                return nil
            }

            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let genres = try decoder.decode([MovieGenre].self, from: data)
                return genres
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                return nil
            }
        }
    
    
    
    func load(ratings: [String: Double], genreFilter: [String] = []) {
            do {
                let recommender = MovieRecommender()
                let input = MovieRecommenderInput(items: ratings, k: 7, restrict_: [], exclude: [])
                
                let result = try recommender.prediction(input: input)
                var tempMovies = [MovieS]()
                
                guard let genres = loadGenres() else {
                                print("No genres found.")
                                return
                            }
                
                for str in result.recommendations {
                    let score = result.scores[str] ?? 0
                    let movieGenre = getGenre(for: str, genres: genres)
                    let movieId = getMovieId(for: str, movie_id: genres)

                    let movie = MovieS(name: "\(str)", score: score, movieGenre: movieGenre, movie_id: movieId)

                    // Filtrar según los géneros, si se proporciona un filtro
                    if !genreFilter.isEmpty {
                        let hasMatchingGenre = movie.movieGenre.contains { genre in
                            genreFilter.contains { filter in genre.lowercased().contains(filter.lowercased()) }
                        }
                        if !hasMatchingGenre {
                            continue
                        }
                    }

                    tempMovies.append(movie)
                }
                
                self.movies = tempMovies
                
            } catch {
                print("Error in prediction: \(error.localizedDescription)")
        }
    }
    
    func getGenre(for movieName: String, genres: [MovieGenre]) -> [String] {
        if let genre = genres.first(where: { $0.title == movieName }) {
                return genre.genres.split(separator: "|").map { String($0) }
            }
            return [] 
        }
    
    func getMovieId(for movieName: String, movie_id: [MovieGenre]) -> Int{
        if let movie_ids = movie_id.first(where: { $0.title == movieName }) {
            return movie_ids.movieId
            }
            return 0
        }
    
        
}

struct MovieS: Identifiable {
    public var id = UUID()
    public var name: String
    public var score: Double
    public var movieGenre: [String]
   public var movie_id: Int
}
