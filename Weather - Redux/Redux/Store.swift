//
//  Store.swift
//  Weather - Redux
//
//  Created by Martin on 21.06.2021.
//

import Combine

protocol Store: ObservableObject where ObjectWillChangePublisher == ObservableObjectPublisher, ReduxReducer.ReduxState == ReduxState, ReduxState.ReduxStore == Self {
    associatedtype ReduxState: State
    associatedtype ReduxReducer: Reducer
    
    var state: ReduxState { get set }
    var storedDispatch: Dispatch { get set }
    
    init(state: ReduxState?)
}

extension Store {
    typealias StoreCreator = (ReduxReducer.Type, ReduxState?) -> Self
    typealias StoreEnhancer = (@escaping StoreCreator) -> StoreCreator
    typealias Middleware = (@escaping Dispatch, @escaping () -> ReduxState) -> DispatchWrapper
    
    var defaultDispatch: Dispatch {
        return { (action: Action) in
            self.reduce(action)
        }
    }
    
    func dispatch(_ action: Action) {
        return storedDispatch(action)
    }
    
    func reduce(_ action: Action) {
        objectWillChange.send()
        state = ReduxReducer.reduce(action, state: state)    
    }
    
    static func createStore(
        reducer: ReduxReducer.Type,
        preloadedState: ReduxState?
    ) -> Self {
        Self.init(state: preloadedState)
    }
    
    static func createStore(
        reducer: ReduxReducer.Type,
        preloadedState: ReduxState?,
        enhancer: StoreEnhancer
    ) -> Self {
        enhancer(createStore)(reducer, preloadedState)
    }
    
    func initialize() -> Self {
        state.initialize(store: self)
        return self
    }
    
    func getState() -> ReduxState { state }
    
    static func applyMiddleware(middlewares: [Middleware]) -> StoreEnhancer {
        return { (createStore: @escaping StoreCreator) in
            return { (reducer: ReduxReducer.Type, initialState: ReduxState?) -> Self in
                let store = createStore(reducer, initialState)
                var newDispatch: Dispatch = store.storedDispatch
                let wrappedDispatch = {(action: Action) in
                    newDispatch(action)
                }
                let chain = middlewares.map {
                    $0(wrappedDispatch, store.getState)
                }
                    
                newDispatch = Composer.compose(chain)(store.storedDispatch)

                store.storedDispatch = newDispatch
                return store
            }
        }
    }
}
