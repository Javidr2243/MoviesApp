//
//  MovieHomeView.swift
//  MovieRecommendations
//
//  Created by JAVIER DAVILA RUIZ on 13/11/24.
//

import SwiftUI

struct MovieHomeView: View {
    
    @StateObject private var movieHomeState = MovieHomeState()
    
    var body: some View {
        List {
            if let firstSection = movieHomeState.sections.first {
                MovieThumbnailCarouselView(
                    movies: firstSection.movies,
                    thumbnailType: firstSection.thumbnailType
                )
                .listRowInsets(.init(top: 8, leading: 0, bottom: 8, trailing: 0))
                .listRowSeparator(.hidden)
            }
        }
        .task { loadMovies(invalidateCache: false) }
        .refreshable { loadMovies(invalidateCache: true) }
        .overlay(
            DataFetchPhaseOverlayView(
                phase: movieHomeState.phase,
                retryAction: { loadMovies(invalidateCache: true) }
            )
        )
        .listStyle(.plain)
        .navigationTitle("Watch Next")
    }
    
    @Sendable
    private func loadMovies(invalidateCache: Bool) {
        Task { await movieHomeState.loadMoviesFromAllEndpoints(invalidateCache: invalidateCache) }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieHomeView()
        }
    }
}
