//
//  Composer.swift
//  Weather - Redux
//
//  Created by Martin on 26.06.2021.
//

import Foundation

typealias Dispatch = (Action) -> Void
typealias DispatchWrapper = (@escaping Dispatch) -> Dispatch

enum Composer {
    static func compose(_ dispatches: [DispatchWrapper]) -> DispatchWrapper {
        let initial: DispatchWrapper = { dispatch in dispatch }
        
        return dispatches.reduce(initial) { (a: @escaping DispatchWrapper, b: @escaping DispatchWrapper) in
            return { (dispatch: @escaping Dispatch) in
                return a(b(dispatch))
            }
        }
    }
}
