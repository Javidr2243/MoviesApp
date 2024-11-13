//
//  ListofGroups.swift
//  MovieRecommendations
//
//  Created by Jimena Gallegos on 13/11/24.
//

import SwiftUI

struct ListofGroups: View {
    private let groups = DataManager.groups
    
    func combinedNames(for group: MoviesGroup) -> String {
            return group.persons.joined(separator: ", ")
        }

    var body: some View {
       
        NavigationView {
            ZStack {
                Color(.black)
                VStack(alignment: .leading){
                    HStack{
                        Text("Groups")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        Spacer()
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundStyle(.white)
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                    
                    ForEach(groups) { grupo in
                        NavigationLink(destination: RecomenderView_Participants(group: grupo)) {
                            HStack(){
                                Text(grupo.image)
                                    .background(
                                        Rectangle()
                                            .fill(Color(red: 65/255, green: 64/255, blue: 67/255, opacity: 1))
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(20))
                                    .font(.system(size: 60))
                                    .padding(20.0)
                                
                                VStack(alignment: .leading){
                                    Text(grupo.name)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.white)
                                    
                                    Text(combinedNames(for: grupo))
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.leading)
                                        .padding(.top, 2)
                                        .padding(.trailing, 10)
                                    
                                }
                                .padding(.leading, 20)
                            }
                        }
                    }
                    Spacer()
                }
                .offset(y: 80)
                .padding()
            }
            .ignoresSafeArea()
        }
        
    }
}

#Preview {
    ListofGroups()
}

