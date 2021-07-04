//
//  ReduxBindable.swift
//  Weather - Redux
//
//  Created by Martin on 21.06.2021.
//

import Combine

@propertyWrapper
final class ReduxBindable<ReduxStore: Store, ReduxState, Action: BindingUpdateAction>
where Action.ReduxState == ReduxState
//      ,
//      ReduxStore.ReduxReducer.ReduxState == ReduxStore.ReduxState,
//      ReduxStore.ReduxState.ReduxStore == ReduxStore
{
    @Published private var state: ReduxState
    weak var store: ReduxStore?
    
    var wrappedValue: ReduxState {
        get {
            return state
        }
        set {
            let action = Action(state: newValue)
            store?.dispatch(action)
        }
    }
    
    var projectedValue: ReduxState {
        get {
            return state
        }
        set {
            state = newValue
        }
    }
    
    var publisher: AnyPublisher<ReduxState, Never> {
        $state.eraseToAnyPublisher()
    }
    
    init(wrappedValue: ReduxState) {
        state = wrappedValue
    }
}
