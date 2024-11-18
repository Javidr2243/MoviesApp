//
//  ContentView.swift
//  MovieRecommendations
//
//  Created by JAVIER DAVILA RUIZ on 11/11/24.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                MovieAndGroupsView()
            }
            .tabItem {
                Label("Home", systemImage: "film")
            }
            .tag(0)
            
            NavigationView {
                MovieSearchView()
            }
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            .tag(1)
            
            NavigationView {
                RecMainView()
            }
            .tabItem {
                Label("Groups", systemImage: "person.3.fill")
            }
            .tag(2)
        }
        .preferredColorScheme(.dark)
    }
}


#Preview {
    ContentView()
}
