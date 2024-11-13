//
//  NewWatchPartyView.swift
//  MovieRecommendations
//
//  Created by Jimena Gallegos on 13/11/24.
//

import SwiftUI

struct NewWatchPartyView: View {
    @ObservedObject var recommender = Recommender()
    var ratings: [String: Double]
    var genres: [String]?
    
    @State private var Romance = false
    @State private var Action = false
    @State private var Thriller = false
    @State private var Horror = false
    @State private var Comedy = false
    @State private var Drama = false
    @State private var Fantasy = false
    @State private var Animation = false
    
    @State private var isShowingRecommendations = false
    
    private func getSelectedGenres() -> [String] {
            var selectedGenres = [String]()
            if Romance { selectedGenres.append("Romance") }
            if Action { selectedGenres.append("Action") }
            if Thriller { selectedGenres.append("Thriller") }
            if Horror { selectedGenres.append("Horror") }
            if Comedy { selectedGenres.append("Comedy") }
            if Drama { selectedGenres.append("Drama") }
            if Fantasy { selectedGenres.append("Fantasy") }
            if Animation { selectedGenres.append("Animation") }
            return selectedGenres
        }
    
    var body: some View {
        NavigationStack {
            VStack{
                Toggle("Romance", isOn: $Romance)
                // .foregroundStyle(.white)
                Toggle("Action", isOn: $Action)
                //.foregroundStyle(.white)
                Toggle("Thriller", isOn: $Thriller)
                //.foregroundStyle(.white)
                Toggle("Horror", isOn: $Horror)
                // .foregroundStyle(.white)
                Toggle("Comedy", isOn: $Comedy)
                Toggle("Drama", isOn: $Drama)
                Toggle("Fantasy", isOn: $Fantasy)
                Toggle("Animation", isOn: $Animation)
                
                Button("Combinar y Obtener Recomendaciones") {
                    recommender.load(ratings: ratings, genreFilter: getSelectedGenres())
                    isShowingRecommendations = true
                }
                .padding()
                .background(Color.green)
                
                NavigationLink(
                    destination: RecomendationsView(movies: recommender.movies),
                    isActive: $isShowingRecommendations) {
                        EmptyView()
                    }
            }
        }
    }
                
}

#Preview {
    NewWatchPartyView(ratings:["Sabrina (1995)": 4.0, "Clueless (1995)": 4.0])
}
