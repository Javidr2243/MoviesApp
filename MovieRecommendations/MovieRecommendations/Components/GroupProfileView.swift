//
//  GroupProfile.swift
//  MovieRecommendations
//
//  Created by Danna Karina Gonzalez Valencia on 13/11/24.
//

import SwiftUI

struct GroupProfileView: View {
    
    var emoji: String

    var body: some View {
        
        Text(emoji)
            .font(.system(size: 60))
            .frame(width: 100, height: 100)
            .background(Color.backgroundGray)
            .cornerRadius(20)
    }
}

#Preview {
    GroupProfileView(emoji: "🌮")
}

