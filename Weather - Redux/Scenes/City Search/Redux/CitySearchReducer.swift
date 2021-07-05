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
        case let action as SetSearchResult:
            newState.showLoading = false
            newState.results = action.state
        case let action as SetError:
            newState.showLoading = false
            newState.$showError = action.state
        case _ as StartLoading:
            newState.showLoading = true
        default:
            break
        }
        
        return newState
    }
}
