//
//  CitySearchReducer.swift
//  Weather - Redux
//
//  Created by Martin on 21.06.2021.
//

func citySearchReducer(state: CitySearchState, action: CitySearchAction) -> CitySearchState {
    var newState = state
    switch action {
    case .startLoading:
        newState.isLoading = true
    case .setSearchedValue(let value):
        newState.searchedCity = value
    case .setWeatherResult(let results):
        newState.isLoading = false
        newState.results = results
    case .showError(let showError):
        if showError {
            newState.isLoading = false
            newState.results = []
        }
        newState.isShowingError = showError
    default:
        break
    }
    
    return newState
}
