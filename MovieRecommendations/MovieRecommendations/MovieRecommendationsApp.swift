//
//  MovieRecommendationsApp.swift
//  MovieRecommendations
//
//  Created by JAVIER DAVILA RUIZ on 11/11/24.
//

import SwiftUI
import SwiftData

@main
struct MovieRecommendationsApp: App {
    
    let container: ModelContainer = {
        let schema = Schema([UserData.self, UserRating.self])
        let container = try! ModelContainer(for: schema, configurations: [])
        return container
    }()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                
        }
        .modelContainer(container)
    }
    
    
}
