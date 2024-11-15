//
//  SearchBarView.swift
//  MovieRecommendations
//
//  Created by Danna Karina Gonzalez Valencia on 13/11/24.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    var searchBarName = "Search username"
    
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.lightGray)
            
            if searchText.isEmpty {
                Text(searchBarName)
                    .foregroundColor(.lightGray)
                    .font(.system(size: 16))
            }

            TextField("", text: $searchText)
                .foregroundColor(.lightGray)
                .font(.system(size: 18))
                .padding(.vertical, 10)
        }
        .padding(.horizontal, 15)
        .background(Color.backgroundGray)
        .cornerRadius(25)
        .padding(.horizontal)

    }
}



#Preview {
    SearchBarView(searchText: .constant(""))
}
