//
//  ContentView.swift
//  MovieRecommendations
//
//  Created by JAVIER DAVILA RUIZ on 11/11/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context  // Access the SwiftData context
    @State private var username: String = ""  // Bindable property for username input
    @State private var showConfirmation = false  // Flag to show confirmation message
    
    // Query to fetch all UserData instances, sorted by username
    @Query(sort: \UserData.username, order: .forward) var usersData: [UserData]

    var body: some View {
        VStack {
            TextField("Enter Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .autocapitalization(.none)
                .disableAutocorrection(true)

            Button("Save User Data") {
                saveUserData()
            }
            .padding()
            .buttonStyle(.borderedProminent)

            if showConfirmation {
                Text("User data saved successfully!")
                    .foregroundColor(.green)
                    .padding()
            }

            // List to display all saved UserData instances
            List {
                ForEach(usersData, id: \.id) { user in
                    VStack(alignment: .leading) {
                        Text("UUID: \(user.id.uuidString)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Text("Username: \(user.username)")
                            .font(.headline)
                        
                        // Display rated movies if available
                        if !user.ratedMovies.isEmpty {
                            Text("Rated Movies:")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            ForEach(user.ratedMovies, id: \.id) { movie in
                                Text("Movie ID: \(movie.movieId), Rating: \(movie.userRating, specifier: "%.1f")")
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
                .onDelete(perform: deleteUserData)
            }
            .padding(.top)
        }
        .padding()
    }

    private func saveUserData() {
        guard !username.isEmpty else { return }  // Ensure the username is not empty

        // Create and insert a new UserData instance
        let newUser = UserData(username: username)
        context.insert(newUser)

        // Attempt to save the context
        do {
            try context.save()
            showConfirmation = true  // Show confirmation on successful save
            username = ""  // Clear the input field
        } catch {
            print("Failed to save user data: \(error)")
        }
    }

    private func deleteUserData(at offsets: IndexSet) {
        // Loop through each offset to delete the corresponding UserData object
        for index in offsets {
            let user = usersData[index]
            context.delete(user)  // Delete the user from the context
        }
        
        // Save the context after deletion
        do {
            try context.save()
        } catch {
            print("Failed to delete user data: \(error)")
        }
    }
}

// Preview
#Preview {
    ContentView()
}

