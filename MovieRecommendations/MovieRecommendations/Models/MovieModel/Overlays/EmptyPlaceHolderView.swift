//
//  EmptyPlaceHolderView.swift
//  MovieRecommendations
//
//  Created by JAVIER DAVILA RUIZ on 13/11/24.
//

import SwiftUI

struct EmptyPlaceholderView: View {
    
    let text: String
    let image: Image?
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            if let image = image {
                image
                    .imageScale(.large)
                    .font(.system(size: 52))
            }
            Text(text)
            Spacer()
        }
    }
}

struct EmptyPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyPlaceholderView(text: "No Movies", image: Image(systemName: "film"))
    }
}
