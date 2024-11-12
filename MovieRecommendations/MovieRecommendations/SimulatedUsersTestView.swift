//
//  SimulatedUsersTestView.swift
//  MovieRecommendations
//
//  Created by JAVIER DAVILA RUIZ on 12/11/24.
//

import SwiftUI

struct TestUserSimulations: View {
    var userSimulations: [UserSimulationElement]  // Passes in userSimData

    var body: some View {
        List(userSimulations, id: \.id) { user in
            Section(header: Text(user.username).font(.headline)) {
                ForEach(user.moviesWatched, id: \.movieID) { movie in
                    VStack(alignment: .leading) {
                        Text("Movie ID: \(movie.movieID)")
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
    TestUserSimulations(userSimulations: userSimData)
}

