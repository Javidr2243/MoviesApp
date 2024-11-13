//
//  ContentView.swift
//  MovieRecommendations
//
//  Created by JAVIER DAVILA RUIZ on 11/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView { MovieAndGroupsView() }
            .tabItem { Label("Home", systemImage: "film")}
            .tag(0)
            
            NavigationView { MovieSearchView() }
            .tabItem { Label("Search", systemImage: "magnifyingglass")}
            .tag(1)
        }
    }
}
#Preview {
    ContentView()
}
