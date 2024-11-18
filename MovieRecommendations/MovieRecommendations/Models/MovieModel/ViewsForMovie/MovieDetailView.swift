//
//  MovieDetailView.swift
//  MovieRecommendations
//
//  Created by JAVIER DAVILA RUIZ on 13/11/24.
//

import SwiftUI

// MARK: - MovieDetailView

struct MovieDetailView: View {
    
    let movieId: Int
    let movieTitle: String
    @StateObject private var movieDetailState = MovieDetailState()
    @State private var selectedTrailerURL: URL?
    
    var body: some View {
        List {
            if let movie = movieDetailState.movie {
                MovieDetailImage(imageURL: movie.backdropURL)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowSeparator(.hidden)
                
                MovieDetailListView(movie: movie, selectedTrailerURL: $selectedTrailerURL)
            }
        }
        .listStyle(.plain)
        .task(loadMovie)
        .overlay(DataFetchPhaseOverlayView(
            phase: movieDetailState.phase,
            retryAction: loadMovie)
        )
        .sheet(item: $selectedTrailerURL) { SafariView(url: $0).edgesIgnoringSafeArea(.bottom)}
        .navigationTitle(movieTitle)
        .preferredColorScheme(.dark) // Force Dark Mode
    }
    
    @Sendable
    private func loadMovie() {
        Task { await self.movieDetailState.loadMovie(id: self.movieId) }
    }
}

// MARK: - MovieDetailListView

struct MovieDetailListView: View {
    
    let movie: Movie
    @Binding var selectedTrailerURL: URL?
    
    var body: some View {
        movieDescriptionSection
            .listRowSeparator(.visible)
        movieCastSection
            .listRowSeparator(.hidden)
        movieTrailerSection
    }
    
    private var movieDescriptionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(movieGenreYearDurationText)
                .font(.headline)
                .foregroundColor(.white) // Use white or other suitable color for dark mode
            Text(movie.overview)
                .foregroundColor(.secondary) // Secondary color adapts well in dark mode
            HStack {
                if !movie.ratingText.isEmpty {
                    Text(movie.ratingText)
                        .foregroundColor(.yellow)
                }
                Text(movie.scoreText)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical)
    }
    
    private var movieCastSection: some View {
        HStack(alignment: .top, spacing: 4) {
            if let cast = movie.cast, !cast.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Starring")
                        .font(.headline)
                        .foregroundColor(.white)
                    ForEach(cast.prefix(9)) { Text($0.name).foregroundColor(.secondary) }
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            
            if let crew = movie.crew, !crew.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    if let directors = movie.directors, !directors.isEmpty {
                        Text("Director(s)")
                            .font(.headline)
                            .foregroundColor(.white)
                        ForEach(directors.prefix(2)) { Text($0.name).foregroundColor(.secondary) }
                    }
                    
                    if let producers = movie.producers, !producers.isEmpty {
                        Text("Producer(s)")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.top)
                        ForEach(producers.prefix(2)) { Text($0.name).foregroundColor(.secondary) }
                    }
                    
                    if let screenwriters = movie.screenWriters, !screenwriters.isEmpty {
                        Text("Screenwriter(s)")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.top)
                        ForEach(screenwriters.prefix(2)) { Text($0.name).foregroundColor(.secondary) }
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.vertical)
    }
    
    @ViewBuilder
    private var movieTrailerSection: some View {
        if let trailers = movie.youtubeTrailers, !trailers.isEmpty {
            Text("Trailers")
                .font(.headline)
                .foregroundColor(.white)
            ForEach(trailers) { trailer in
                Button(action: {
                    guard let url = trailer.youtubeURL else { return }
                    selectedTrailerURL = url
                }) {
                    HStack {
                        Text(trailer.name)
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "play.circle.fill")
                            .foregroundColor(Color(UIColor.systemBlue))
                    }
                }
            }
        }
    }
    
    private var movieGenreYearDurationText: String {
        "\(movie.genreText) · \(movie.yearText) · \(movie.durationText)"
    }
}

// MARK: - MovieDetailImage

struct MovieDetailImage: View {
    
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Color.black // Dark background
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear { imageLoader.loadImage(with: imageURL) }
    }
}

// MARK: - URL Extension

extension URL: Identifiable {
    
    public var id: Self { self }
}

// MARK: - Preview

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieDetailView(movieId: Movie.stubbedMovie.id, movieTitle: "The Godfather 2")
        }
        .preferredColorScheme(.dark) // Ensure preview is in dark mode
    }
}
