//
//  UserInfoView.swift
//  MovieRecommendations
//
//  Created by Danna Karina Gonzalez Valencia on 13/11/24.
//

import SwiftUI

struct UserInfoView: View {
    var userFullName: String
    var username: String

    var body: some View {
        ZStack{
            Color.black
            HStack{
                UserProfileView(image: Image("memoji"))
                    .padding()
                VStack(alignment: .leading){
                    Text(userFullName + " /")
                        .foregroundStyle(Color.white)
                    Text(username)
                        .foregroundStyle(Color.white)
                }
                
            }
        }
        
    }
}

#Preview {
    UserInfoView(userFullName: "Bella Hadid", username: "@bellabella")
}
