//
//  AppStore.swift
//  Weather - Redux
//
//  Created by Martin on 19.09.2021.
//

import Combine
import Foundation

typealias AppStore = Store<AppState, AppAction>

final class Store<State, Action>: ObservableObject {
    
    @Published private(set) var state: State
    
    private var disposeBag = [AnyCancellable]()
    private let reducer: Reducer<State, Action>
    private let middlewares: [Middleware<State, Action>]
    
    init(
        initialState: State,
        reducer: @escaping Reducer<State, Action>,
        middlewares: [Middleware<State, Action>] = []
    ) {
        self.state = initialState
        self.reducer = reducer
        self.middlewares = middlewares
    }
    
    func dispatch(_ action: Action) {
        state = reducer(state, action)
        
        middlewares
            .map { $0(state, action) }
            .forEach { [weak self] middleware in
                guard let self = self else { return }
                
                return middleware
                    .receive(on: DispatchQueue.main)
                    .sink(receiveValue: self.dispatch)
                    .store(in: &disposeBag)
            }
    }
}
