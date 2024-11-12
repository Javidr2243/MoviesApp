//
//  SimulatedUsersTestView.swift
//  MovieRecommendations
//
//  Created by JAVIER DAVILA RUIZ on 12/11/24.
//

import SwiftUI

struct TestUserSimulations: View {
    @StateObject var viewModel: UserSimulationsViewModel

    var body: some View {
        List(viewModel.userSimulations, id: \.id) { user in
            Section(header: Text(user.username).font(.headline)) {
                ForEach(user.moviesWatched, id: \.movieID) { movie in
                    VStack(alignment: .leading) {
                        // Display movie ID and title
                        Text("ID: \(movie.movieID) - Title: \(viewModel.movieTitle(for: movie.movieID))")
                            .font(.headline)
                        Text("Rating: \(movie.rating, specifier: "%.1f")")
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .navigationTitle("User Simulations")
    }
}

// Preview
#Preview {
    TestUserSimulations(viewModel: UserSimulationsViewModel(userSimulations: userSimData, movies: movieData))
}
