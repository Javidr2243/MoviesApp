//
//  DataFetchState.swift
//  MovieRecommendations
//
//  Created by JAVIER DAVILA RUIZ on 13/11/24.
//

import Foundation

enum DataFetchPhase<V> {
    
    case empty
    case success(V)
    case failure(Error)
    
    var value: V? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
    
}
