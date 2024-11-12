//
//  GroupSModel.swift
//  MovieRecommendations
//
//  Created by JAVIER DAVILA RUIZ on 12/11/24.
//

import Foundation
import SwiftData

@Model
class GroupSModel {
    @Attribute(.unique) var group_id: UUID = UUID()
    var name: String
    var userDataMembers: [UserData] = []              // Array for UserData members
    var userSimulationMembers: [UserSimulationElement] = []  // Array for UserSimulationElement members

    init(name: String, userDataMembers: [UserData] = [], userSimulationMembers: [UserSimulationElement] = []) {
        self.name = name
        self.userDataMembers = userDataMembers
        self.userSimulationMembers = userSimulationMembers
    }
}
