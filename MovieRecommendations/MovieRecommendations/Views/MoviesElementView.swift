//
//  MoviesElementView.swift
//  MovieRecommendations
//
//  Created by JAVIER DAVILA RUIZ on 13/11/24.
//

import SwiftUI

struct MoviesElementView: View {

    @State var MovieElement: MovieElement
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    MoviesElementView(MovieElement: movieData[0])
}
