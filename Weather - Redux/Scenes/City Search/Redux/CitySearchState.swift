//
//  CitySearchState.swift
//  Weather - Redux
//
//  Created by Martin on 26.06.2021.
//

import Foundation

final class CitySearchState: State {
    typealias ReduxStore = CitySearchStore
    
    var results = [CurrentWeather]()
    var lastCharacterEntered: Date? = nil
    @ReduxBindable<CitySearchStore, String, UpdateSearchedText> var searchedCity = ""
    @ReduxBindable<CitySearchStore, Bool, SetError> var showError = false
    
    var deepcopy: CitySearchState {
        let newState = CitySearchState()
        newState.results = self.results
        newState.lastCharacterEntered = self.lastCharacterEntered
        // ty podtrzitka vysvelis diky tomu odkazu na Apple fora, kde se vysvětluje co dělají property wrappery na pozadi
        newState._searchedCity = _searchedCity
        newState._showError = _showError
        return newState
    }
    
    func initialize(store: CitySearchStore) {
        _searchedCity.store = store
        _showError.store = store
    }
}
