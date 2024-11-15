//
//  MovieSearchView.swift
//  MovieRecommendations
//
//  Created by JAVIER DAVILA RUIZ on 13/11/24.
//

import SwiftUI

@available(iOS 16, macOS 13.0, *)



struct MovieSearchView: View {
    
    @StateObject var movieSearchState = MovieSearchState()
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UICollectionView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        ZStack {
            Color(.black)
            List {
                ForEach(movieSearchState.movies) { movie in
                    NavigationLink(destination: MovieDetailView(movieId: movie.id, movieTitle: movie.title)) {
                        MovieRowView(movie: movie).padding(.vertical, 8)
                    }
                    
                }
                .listRowBackground(Color.black)
            }
            .preferredColorScheme(.dark)
            .searchable(text: $movieSearchState.query, prompt: "Search movies")
            .overlay(overlayView)
            .onAppear { movieSearchState.startObserve() }
            .listStyle(.plain)
            .navigationTitle("Search")
            .frame(maxHeight: 700)
            .background(.black)
            
        }
        .ignoresSafeArea()
        
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch movieSearchState.phase {
            
        case .empty:
            if movieSearchState.trimmedQuery.isEmpty {
                EmptyPlaceholderView(text: "Search your favorite movie", image: Image(systemName: "magnifyingglass"))
                    .foregroundStyle(.white)
            } else {
                ProgressView()
            }
            
        case .success(let values) where values.isEmpty:
            EmptyPlaceholderView(text: "No results", image: Image(systemName: "film"))
                .foregroundStyle(.white)
            
        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: {
                Task {
                    await movieSearchState.search(query: movieSearchState.query)
                }
            })
            
        default: EmptyView()
        }
    }
    
}

struct MovieRowView: View {
    
    let movie: Movie
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            MovieThumbnailView(movie: movie, thumbnailType: .poster(showTitle: false))
                .frame(width: 61, height: 92)
            
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                    .foregroundStyle(.white)
                
                Text(movie.yearText)
                    .font(.subheadline)
                    .foregroundStyle(.white)
                
                //Spacer()
                
                Text(movie.ratingText)
                    .foregroundColor(.yellow)
            }
        }
        
    }
}


struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieSearchView()
        }
    }
}
