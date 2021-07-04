//
//  ThunkMiddleware.swift
//  Weather - Redux
//
//  Created by Martin on 27.06.2021.
//

import Foundation

enum ThunkMiddleware<ReduxStore: Store>: Middleware {
    static var middleware: ReduxStore.Middleware {
        return { (dispatch: @escaping Dispatch, getState: @escaping () -> ReduxStore.ReduxState) in
            return { (next: @escaping Dispatch) in
                return { (action: Action) in
                    if let thunk = action as? Thunk<ReduxStore> {
                        return thunk.action(dispatch, getState)
                    }

                    return next(action)
                }
            }
        }
    }
}
