//
//  UserProfileView.swift
//  MovieRecommendations
//
//  Created by Danna Karina Gonzalez Valencia on 13/11/24.
//

import SwiftUI

struct UserProfileView: View {
    
    var image: Image
    
    var body: some View {
        
        ZStack {
                    Circle()
                        .fill(Color.backgroundGray)
                        .frame(width: 100, height: 100)
                    
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.backgroundGray, lineWidth: 8) 
                        )
                }
        
    }
}

#Preview {
    UserProfileView(image: Image("memoji"))
}
