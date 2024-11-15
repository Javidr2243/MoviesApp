//
//  ContentView.swift
//  MovieRecommendations
//
//  Created by JAVIER DAVILA RUIZ on 11/11/24.
//

import SwiftUI

struct ContentView: View {
    init() {
        customizeTabBarAppearance()
    }
    
    var body: some View {
        TabView {
            NavigationView { MovieAndGroupsView() }
                .tabItem {
                    Label("Home", systemImage: "film")
                }
                .tag(0)
            
            NavigationView { MovieSearchView() }
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(1)
            
            NavigationView { RecMainView() }
                .tabItem {
                    Label("Groups", systemImage: "person.3.fill")
                }
                .tag(2)
        }
    }
    
    private func customizeTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black
        
        // Set item appearance
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.lightGray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.purpleApp
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

#Preview {
    ContentView()
}
