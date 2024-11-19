//
//  ContentView.swift
//  MovieRecommendations
//
//  Created by JAVIER DAVILA RUIZ on 11/11/24.
//

import SwiftUI

import SwiftUI

struct ContentView: View {

    
    struct TabBarAppearanceModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .onAppear {
                    let appearance = UITabBarAppearance()
                    appearance.configureWithOpaqueBackground()
                    appearance.backgroundColor = UIColor.purpleApp
                    appearance.stackedLayoutAppearance.selected.iconColor = UIColor.white
                    appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
                    appearance.stackedLayoutAppearance.normal.iconColor = UIColor.white.withAlphaComponent(0.6)
                    appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white.withAlphaComponent(0.6)]
                    
                    UITabBar.appearance().standardAppearance = appearance
                    UITabBar.appearance().scrollEdgeAppearance = appearance
                }
        }
    }
    
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
        .preferredColorScheme(.dark)      .modifier(TabBarAppearanceModifier())
    }

}


#Preview {
    ContentView()
}
