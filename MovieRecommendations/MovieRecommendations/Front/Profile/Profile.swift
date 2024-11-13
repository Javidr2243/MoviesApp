//
//  Profile.swift
//  MovieRecommendations
//
//  Created by Danna Karina Gonzalez Valencia on 12/11/24.
//

import SwiftUI

struct Profile: View {
    
    @State private var text: String = ""

    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            VStack{
                Text("Create your account")
                    .foregroundColor(.white)
                TextField("Username...", text: $text)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    print("Next button pressed")
                }) {
                    Text("Next")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
    }
}

#Preview {
    Profile()
}
