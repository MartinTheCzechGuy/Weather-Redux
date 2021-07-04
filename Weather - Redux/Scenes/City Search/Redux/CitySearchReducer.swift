//
//  CitySearchReducer.swift
//  Weather - Redux
//
//  Created by Martin on 21.06.2021.
//

import Foundation

enum CitySearchReducer: Reducer {
    static func reduce(_ action: Action, state: CitySearchState) -> CitySearchState {
        let newState = state.deepcopy
        
        switch action {
        case let action as UpdateSearchedText:
            newState.$searchedCity = action.state
            newState.lastCharacterEntered = Date()
        //case let action as SearchCity:
        case let action as SetSearchResult:
            newState.results = action.state
            newState.lastCharacterEntered = nil
        case let action as SetError:
            newState.$showError = action.state
            newState.lastCharacterEntered = nil
        default:
            break
        }
        
        return newState
    }
}
