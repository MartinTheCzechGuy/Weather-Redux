//
//  CitySearchStore.swift
//  Weather - Redux
//
//  Created by Martin on 21.06.2021.
//

import Combine

final class CitySearchStore: Store {
        
    typealias ReduxReducer = CitySearchReducer
    
    var state: CitySearchState {
        didSet {
            print("set value 1 \(state.results.count)")
        }
    }
    var objectWillChange = ObservableObjectPublisher()
    lazy var storedDispatch = defaultDispatch
    
    init(state: CitySearchState?) {
        self.state = state ?? CitySearchState()
    }
}
