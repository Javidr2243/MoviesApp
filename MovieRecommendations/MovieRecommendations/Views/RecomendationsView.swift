//
//  RecomendationsView.swift
//  MovieRecommendations
//
//  Created by Jimena Gallegos on 13/11/24.
//

import SwiftUI

/*struct RecomendationsView: View {
    var movies: [MovieS]
    var body: some View {
        VStack {
            List(movies) { movie in
                VStack(alignment: .leading) {
                    Text(movie.name)
                    Text("\(movie.score, specifier: "%.2f")")
                        .font(.system(size: 14))
                        .foregroundColor(Color.gray)
                }
            }
            .navigationTitle("Películas Recomendadas")
        }
    }
}

#Preview {
    RecomendationsView(movies: [
        MovieS(name: "Inception", score: 4.5, movieGenre: ["Animation"]),
           MovieS(name: "The Matrix", score: 4.7, movieGenre: ["Animation"]),
           MovieS(name: "Toy Story", score: 4.3, movieGenre: ["Animation"])
       ])
}*/

import SwiftUI

import SwiftUI

struct RecomendationsView: View {
    var movies: [MovieS]
    @State private var activeCardIndex: Int? = 0
    
    var body: some View {
        ZStack {
            Color(.black)
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
                            VStack {
                                Rectangle()
                                    .fill(.red)
                                    .frame(width: 350, height: 500)
                                    .cornerRadius(20)
                                
                                
                                Text(movies[index].name)
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .padding(.top)
                                
                                Text("Genres: \(movies[index].movieGenre.joined(separator: ", "))")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                
                                
                            }
                            .padding()
                            .id(index)
                        }
                    }
                    .padding()
                }
                .scrollTargetLayout()
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $activeCardIndex)
                .scrollIndicators(.never)
                .frame(height: 200)
                
                pagingControl
                Spacer()
            }
        }
        .ignoresSafeArea()
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


#Preview {
    RecomendationsView(movies: [
        MovieS(name: "Inception", score: 4.5, movieGenre: ["Animation"], movie_id: 5),
        MovieS(name: "The Matrix", score: 4.7, movieGenre: ["Animation"], movie_id: 4),
        MovieS(name: "Toy Story", score: 4.3, movieGenre: ["Animation"], movie_id: 3)
       ])
}

