//
//  NewWatchpartyMembers.swift
//  MovieRecommendations
//
//  Created by Danna Karina Gonzalez Valencia on 13/11/24.
//

import SwiftUI


struct NewWatchpartyMembers: View {
    let group: MoviesGroup
    @ObservedObject var recommender = Recommender()
    @State var combinedRatings = ["Sabrina (1995)": 4.0, "Clueless (1995)": 4.0]
    @State private var selectedSets: [Bool]
    @State private var nextView = false
    init(group: MoviesGroup) {
        self.group = group
        self._selectedSets = State(initialValue: Array(repeating: false, count: group.persons.count))
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                
                
                HStack {
                    GroupProfileView(emoji: group.image)
                        .padding()
                    Text(group.name)
                        .foregroundColor(.white)
                        .font(.title)
                }
                
                Text("Choose participant members")
                    .foregroundColor(.white)
                    .font(.title2)
                
                SearchBarView(searchBarName: "Search username")
                
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(group.persons.indices, id: \.self) { index in
                            HStack {
                                UserInfoView(userFullName: group.persons[index], username: "")
                                //Spacer()
                                Toggle("", isOn: $selectedSets[index])
                                    .labelsHidden()
                                    .toggleStyle(SwitchToggleStyle(tint: .purpleApp))
                            }
                            .padding()
                            //.background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .frame(height: 120)
                            .offset(x:-20)
                        }
                    }
                }
                
                Button(action: {
                    let selectedRatingSets = getSelectedSets()
                    combinedRatings = RatingSet.combineSets(sets: selectedRatingSets)
                    nextView = true
                }) {
                    Text("Next")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(width: 200, height: 60)
                }
                .background(Color(.purpleApp))
                .foregroundStyle(.white)
                .cornerRadius(30)
                .padding(.top, 60)
                
                
                /*NavigationLink(destination: NewWatchPartyView(group: group, ratings: combinedRatings)),isActive: $nextView) {
                        EmptyView()
                    }*/
                NavigationLink(
                    destination: NewWatchPartyView(group: group, ratings: combinedRatings),
                    isActive: $nextView) {
                        EmptyView()
                    }
            }
            .padding()
        }
    }
    
    
    private func getSelectedSets() -> [[String: Double]] {
        var selectedSetsList = [[String: Double]]()
        
        for (index, isSelected) in selectedSets.enumerated() {
            if isSelected, let set = RatingSet.set(for: group.persons[index]) {
                selectedSetsList.append(set)
            }
        }
        
        return selectedSetsList
    }
}

#Preview {
    NewWatchpartyMembers(group: MoviesGroup(name: "Checo y los Perez", persons: ["Gigi", "Javier"], image: "🌮"))
}
