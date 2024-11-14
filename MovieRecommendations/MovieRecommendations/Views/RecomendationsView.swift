//
//  RecomendationsView.swift
//  MovieRecommendations
//
//  Created by Jimena Gallegos on 13/11/24.
//

import SwiftUI

struct RecomendationsView: View {
    var movies: [MovieS]
    @State private var activeCardIndex: Int? = 0
    
    var body: some View {
        ZStack {
            Color(.black).ignoresSafeArea()
            VStack {
                Spacer()
                Text("Recommendations")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .offset(y: -180)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(0..<movies.count, id: \.self) { index in
                            let movie = movies[index]
                            NavigationLink(
                                destination: MovieDetailView(
                                    movieId: movie.movie_id,
                                    movieTitle: movie.name
                                )
                            ) {
                                VStack {
                                    MoviePosterImageView(movieId: movie.movie_id)
                                        .frame(width: 350, height: 500)
                                        .cornerRadius(20)
                                    
                                    Text(movie.name)
                                        .font(.headline)
                                        .foregroundColor(Color.white)
                                        .padding(.top)
                                    
                                    Text("Genres: \(movie.movieGenre.joined(separator: ", "))")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                    
                                }
                                .padding()
                                .id(index)
                                
                                
                            }
                        }
                    }
                    .padding()
                }
                .scrollTargetLayout()
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $activeCardIndex)
                .scrollIndicators(.never)
                .frame(height: 600) // Adjust height for full card display
                
                pagingControl
                Spacer()
            }
        }
    }
    
    var pagingControl: some View {
        HStack {
            ForEach(0..<movies.count, id: \.self) { index in
                Button {
                    withAnimation {
                        activeCardIndex = index
                    }
                } label: {
                    Image(systemName: activeCardIndex == index ? "circle.fill" : "circle")
                        .foregroundStyle(Color(uiColor: .systemGray3))
                }
            }
        }
        .offset(y: 200)
    }
}

struct MoviePosterImageView: View {
    @StateObject private var imageLoader = ImageLoader()
    @State private var posterPath: String? = nil
    let movieId: Int
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.3) // Placeholder background
            
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else if imageLoader.isLoading {
                ProgressView() // Loading indicator
            } else {
                Text("No Image Available")
                    .foregroundColor(.white)
            }
        }
        .onAppear {
            fetchPosterPath()
        }
    }
    
    private func fetchPosterPath() {
        Task {
            do {
                let movie = try await MovieStore.shared.fetchMovie(id: movieId)
                if let posterPath = movie.posterPath {
                    let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
                    imageLoader.loadImage(with: url!)
                }
            } catch {
                print("Failed to fetch movie details: \(error)")
            }
        }
    }
}

#Preview {
    RecomendationsView(movies: [
        MovieS(name: "Inception", score: 4.5, movieGenre: ["Animation"], movie_id: 5),
        MovieS(name: "The Matrix", score: 4.7, movieGenre: ["Animation"], movie_id: 4),
        MovieS(name: "Toy Story", score: 4.3, movieGenre: ["Animation"], movie_id: 3)
       ])
}

