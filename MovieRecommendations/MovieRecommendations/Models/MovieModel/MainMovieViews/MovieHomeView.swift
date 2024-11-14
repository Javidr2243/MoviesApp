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
        ZStack {
            Color.black
                .ignoresSafeArea() // Sets the entire screen background to black
            
            List {
                VStack(alignment: .leading) {
                    Text("Watch Next")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.leading, .bottom], 8) // Adjust spacing below the title if needed
                    
                    if let firstSection = movieHomeState.sections.first {
                        MovieThumbnailCarouselView(
                            movies: firstSection.movies,
                            thumbnailType: firstSection.thumbnailType
                        )
                        .listRowInsets(EdgeInsets()) // Removes all padding around the row
                        .background(Color.black) // Ensures each row background is black
                    }
                }
                .listRowInsets(EdgeInsets()) // Ensures no padding around the VStack
                .background(Color.black) // Black background for VStack inside List
            }
            .listStyle(.plain)
            .background(Color.clear) // Makes the List background transparent
            .task { loadMovies(invalidateCache: false) }
            .refreshable { loadMovies(invalidateCache: true) }
            .overlay(
                DataFetchPhaseOverlayView(
                    phase: movieHomeState.phase,
                    retryAction: { loadMovies(invalidateCache: true) }
                )
            )
        }
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
