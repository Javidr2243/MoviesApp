import SwiftUI
import CoreML
import Combine

struct RecomenderView_Participants: View {
    let group: Group
    @ObservedObject var recommender = Recommender()
    @State var combinedRatings = ["Sabrina (1995)": 4.0, "Clueless (1995)": 4.0]
    @State private var selectedSets: [Bool]
    
    init(group: Group) {
        self.group = group
        self._selectedSets = State(initialValue: Array(repeating: false, count: group.persons.count))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    ForEach(group.persons.indices, id: \.self) { index in
                        Button(group.persons[index]) {
                            selectedSets[index].toggle()
                        }
                        .padding()
                        .background(selectedSets[index] ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }
                
                Button("Combinar y Obtener Recomendaciones") {
                    let selectedRatingSets = getSelectedSets()
                    combinedRatings = RatingSet.combineSets(sets: selectedRatingSets)
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                NavigationLink(destination: NewWatchPartyView(ratings: combinedRatings)) {
                    Text("Next")
                }
            }
            .navigationBarTitle("CoreMLRecommender", displayMode: .inline)
        }
    }
    
    private func getSelectedSets() -> [[String: Double]] {
        var selectedSetsList = [[String: Double]]()
        
        for (index, isSelected) in selectedSets.enumerated() {
            if isSelected {
                if let set = RatingSet.set(for: group.persons[index]) {
                    selectedSetsList.append(set)
                }
            }
        }
        
        return selectedSetsList
    }
    
}

#Preview {
    RecomenderView_Participants(group: Group(name: "Grupo 1", persons: ["Gigi", "Javier"], image: ""))
}
