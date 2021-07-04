//
//  Reducer.swift
//  Weather - Redux
//
//  Created by Martin on 21.06.2021.
//

protocol Reducer {
    associatedtype ReduxState
    
    static func reduce(_ action: Action, state: ReduxState) -> ReduxState
}
