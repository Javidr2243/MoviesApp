//
//  InsideGroupView.swift
//  MovieRecommendations
//
//  Created by Jimena Gallegos on 13/11/24.
//

import SwiftUI

struct InsideGroupView: View {
    let group: MoviesGroup

        var body: some View {
            List(group.persons, id: \.self) { persona in
                Text(persona)
            }
            .navigationTitle(group.name)
        }
}

#Preview {
    InsideGroupView(group: MoviesGroup(name: "Grupo 1", persons: ["Gigi", "Danna"], image:""))
}
