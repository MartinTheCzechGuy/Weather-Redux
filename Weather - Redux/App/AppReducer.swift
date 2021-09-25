//
//  AppReducer.swift
//  Weather - Redux
//
//  Created by Martin on 19.09.2021.
//

typealias Reducer<State, Action> = (State, Action) -> State

func appReducer(state: AppState, action: AppAction) -> AppState {
    var newState = state
    switch action {
    case .citySearch(let action):
        newState.searchedCity = citySearchReducer(state: state.searchedCity, action: action)
    }
    
    return newState
}
