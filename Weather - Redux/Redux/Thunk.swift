//
//  Thunk.swift
//  Weather - Redux
//
//  Created by Martin on 27.06.2021.
//

import Foundation

struct Thunk<ReduxStore: Store>: Action {
    typealias ThunkAction = (@escaping Dispatch, () -> ReduxStore.ReduxState) -> Void
    
    var action: ThunkAction
    
    init(action: @escaping ThunkAction) {
        self.action = action
    }
}
