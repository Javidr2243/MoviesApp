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
                .ignoresSafeArea()
            VStack {
                List {
                    VStack(alignment: .leading) {
                        Text("Watch Next")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding([.leading, .bottom], 8)
                        
                        if movieHomeState.sections.indices.contains(0) {
                            let firstSection = movieHomeState.sections[0]
                            MovieThumbnailCarouselView(
                                movies: firstSection.movies,
                                thumbnailType: firstSection.thumbnailType
                            )
                            .listRowInsets(EdgeInsets())
                            .background(Color.black)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .background(Color.black)
                    
                    
                    VStack(alignment: .leading) {
                        Text("Popular")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding([.leading, .bottom], 8)
                        
                        if movieHomeState.sections.indices.contains(1) {
                            let secondSection = movieHomeState.sections[1]
                            MovieThumbnailCarouselView(
                                movies: secondSection.movies,
                                thumbnailType: secondSection.thumbnailType
                            )
                            .listRowInsets(EdgeInsets())
                            .background(Color.black)
                        }
                    }
                    .padding(.top,40)
                    .listRowInsets(EdgeInsets())                    .background(Color.black)
                }
                .listStyle(.plain)
                .background(Color.clear)
                .task { loadMovies(invalidateCache: false) }
                .refreshable { loadMovies(invalidateCache: true) }
                .overlay(
                    DataFetchPhaseOverlayView(
                        phase: movieHomeState.phase,
                        retryAction: { loadMovies(invalidateCache: true) }
                    )
                )
            }
            .offset(y: 40)
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

