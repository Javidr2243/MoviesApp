//
//  NewWatchPartyView.swift
//  MovieRecommendations
//
//  Created by Jimena Gallegos on 13/11/24.
//

import SwiftUI

struct NewWatchPartyView: View {
    @ObservedObject var recommender = Recommender()
    let group: MoviesGroup
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
        //NavigationStack {
            ZStack {
                Color(.black)
                VStack(){
                    HStack{
                        Text(group.image)
                            .background(
                                Rectangle()
                                    .fill(Color(red: 65/255, green: 64/255, blue: 67/255, opacity: 1))
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(20))
                            .font(.system(size: 60))
                            .padding(20.0)
                        Spacer()
                        Text(group.name)
                            .font(.title)
                            .fontWeight(.semibold)
                            .lineLimit(2)
                            .foregroundStyle(.white)
                        
                    }
                    
                    HStack {
                        Text("Genre")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    
                    Toggle("Romance", isOn: $Romance)
                        .foregroundStyle(.white)
                        .tint(.purpleApp)
                    Toggle("Action", isOn: $Action)
                        .foregroundStyle(.white)
                        .tint(.purpleApp)
                    Toggle("Thriller", isOn: $Thriller)
                        .foregroundStyle(.white)
                        .tint(.purpleApp)
                    Toggle("Horror", isOn: $Horror)
                        .foregroundStyle(.white)
                        .tint(.purpleApp)
                    Toggle("Comedy", isOn: $Comedy)
                        .foregroundStyle(.white)
                        .tint(.purpleApp)
                    Toggle("Drama", isOn: $Drama)
                        .foregroundStyle(.white)
                        .tint(.purpleApp)
                    Toggle("Fantasy", isOn: $Fantasy)
                        .foregroundStyle(.white)
                        .tint(.purpleApp)
                    Toggle("Animation", isOn: $Animation)
                        .foregroundStyle(.white)
                        .tint(.purpleApp)
                    
                    
                    Button(action: {
                        recommender.load(ratings: ratings, genreFilter: getSelectedGenres())
                        isShowingRecommendations = true
                    }) {
                        Text("Done")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding()
                            .frame(width: 200, height: 60)
                    }
                    .background(Color(.purpleApp))
                    .foregroundStyle(.white)
                    .cornerRadius(30)
                    .padding(.top, 60)

                    
                    
                    NavigationLink(
                        destination: RecomendationsView(movies: recommender.movies),
                        isActive: $isShowingRecommendations) {
                            EmptyView()
                        }
                }
                .frame(maxWidth: 350)
            }
            .ignoresSafeArea()
        }
   // }
                
}

#Preview {
    NewWatchPartyView(group: MoviesGroup(name: "Checo y los Perez", persons: ["Gigi", "Javier"], image: "🌮"), ratings:["Sabrina (1995)": 4.0, "Clueless (1995)": 4.0])
}
