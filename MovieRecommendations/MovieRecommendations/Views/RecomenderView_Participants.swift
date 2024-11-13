import SwiftUI
import CoreML
import Combine

struct RecomenderView_Participants: View {
    let group: Group
    @ObservedObject var recommender = Recommender()
    
    @State private var selectedSets: [Bool]
    
    init(group: Group) {
        self.group = group
        // Inicializamos selectedSets con el tamaño del array de personas y con todos los valores en falso
        self._selectedSets = State(initialValue: Array(repeating: false, count: group.persons.count))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Botones para seleccionar múltiples sets dinámicamente usando personas
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
                
                // Botón para combinar los sets seleccionados y cargarlos
                Button("Combinar y Obtener Recomendaciones") {
                    let selectedRatingSets = getSelectedSets()
                    let combinedRatings = RatingSet.combineSets(sets: selectedRatingSets)
                    recommender.load(ratings: combinedRatings)
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                List(recommender.movies) { movie in
                    VStack(alignment: .leading) {
                        Text(movie.name)
                        Text("\(movie.score, specifier: "%.2f")")
                            .font(.system(size: 14))
                            .foregroundColor(Color.gray)
                    }
                }
            }
            .navigationBarTitle("CoreMLRecommender", displayMode: .inline)
        }
    }
    
    // Función para obtener los sets seleccionados
    private func getSelectedSets() -> [[String: Double]] {
        var selectedSetsList = [[String: Double]]()
        
        for (index, isSelected) in selectedSets.enumerated() {
            if isSelected {
                // Usa el nombre de la persona para acceder al conjunto de ratings adecuado
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
