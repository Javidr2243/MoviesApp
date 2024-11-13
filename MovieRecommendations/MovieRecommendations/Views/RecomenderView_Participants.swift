//
//  RecomenderView_Participants.swift
//  MovieRecommendations
//
//  Created by Jimena Gallegos on 12/11/24.
//

import SwiftUI
import CoreML


import SwiftUI
import Combine
import CoreML

struct RecomenderView_Participants: View {
    @ObservedObject var recommender = Recommender()
    
    @State private var selectedSets: [Bool] = [false, false, false] // Mantiene el estado de selección de los conjuntos
    
    var body: some View {
        NavigationView {
            VStack {
                // Título que indica los conjuntos seleccionados
                /*Text("Conjuntos seleccionados:")
                    .font(.headline)
                    .padding(.top, 10)
                
                // Lista de conjuntos seleccionados
                VStack(alignment: .leading) {
                    if selectedSets[0] {
                        Text("Set 1: Toy Story y Star Wars")
                            .foregroundColor(.green)
                    }
                    if selectedSets[1] {
                        Text("Set 2: The Matrix y The Godfather")
                            .foregroundColor(.green)
                    }
                    if selectedSets[2] {
                        Text("Set 3: The Dark Knight y Inception")
                            .foregroundColor(.green)
                    }
                }
                .padding()*/

                // Botones para seleccionar múltiples sets
                HStack {
                    Button("Javier") {
                        selectedSets[0].toggle()
                    }
                    .padding()
                    .background(selectedSets[0] ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    
                    Button("Danna") {
                        selectedSets[1].toggle()
                    }
                    .padding()
                    .background(selectedSets[1] ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)

                    Button("Gigi") {
                        selectedSets[2].toggle()
                    }
                    .padding()
                    .background(selectedSets[2] ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
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
                        Text("\(movie.score, specifier: "%.2f")")  // Mostrar el promedio con 2 decimales
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
        
        if selectedSets[0] { selectedSetsList.append(RatingSet.javier) }
        if selectedSets[1] { selectedSetsList.append(RatingSet.danna) }
        if selectedSets[2] { selectedSetsList.append(RatingSet.gigi) }
        
        return selectedSetsList
    }
}


#Preview {
    RecomenderView_Participants()
}
