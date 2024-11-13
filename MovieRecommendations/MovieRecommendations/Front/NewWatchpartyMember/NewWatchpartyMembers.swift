//
//  NewWatchpartyMembers.swift
//  MovieRecommendations
//
//  Created by Danna Karina Gonzalez Valencia on 13/11/24.
//

import SwiftUI

struct NewWatchpartyMembers: View {
    
    var groupName: String
    @State private var isToggled: Bool = false // Estado para el Toggle
    
    var body: some View {
        
        ZStack{
            Color.black
                .ignoresSafeArea()
            VStack{
                HStack{
                    GroupProfileView(emoji: "🌮")
                        .padding()
                    Text(groupName)
                        .foregroundStyle(Color.white)
                        .font(.title)
                }
                Text("Choose participant members")
                    .foregroundStyle(Color.white)
                    .font(.title2)

                SearchBarView(searchBarName: "Search username")
                HStack{
                    UserInfoView(userFullName: "Bella Hadid", username: "@bellabella")
                    Toggle("", isOn: $isToggled)
                                    .labelsHidden()
                }
            }
        }
    }
}

#Preview {
    NewWatchpartyMembers(groupName: "Checo y los Pérez")
}
