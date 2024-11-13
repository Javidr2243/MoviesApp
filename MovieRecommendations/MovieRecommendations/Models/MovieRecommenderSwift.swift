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
    
    
    func load(ratings: [String: Double], genreFilter: String? = nil) {
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
                    let movieGenre = getGenre(for: str, genres: genres)   // Obtener el género de la película

                    let movie = MovieS(name: "\(str)", score: score, movieGenre: movieGenre)

                    // Filtrar según el género, si se proporciona un filtro
                    if let genreFilter = genreFilter, !movie.movieGenre.contains(genreFilter) {
                        continue
                    }

                    tempMovies.append(movie)
                }
                
                self.movies = tempMovies
                
            } catch {
                print("Error in prediction: \(error.localizedDescription)")
        }
    }
    
    func getGenre(for movieName: String, genres: [MovieGenre]) -> [String] {
            // Buscar el género de la película en la lista de géneros
        if let genre = genres.first(where: { $0.title == movieName }) {
                // Dividir la cadena de géneros por el delimitador '|'
                return genre.genres.split(separator: "|").map { String($0) }
            }
            return []  // Si no se encuentra, devolvemos un array vacío
        }
        
}

struct MovieS: Identifiable {
    public var id = UUID()
    public var name: String
    public var score: Double
    public var movieGenre: [String]
}
