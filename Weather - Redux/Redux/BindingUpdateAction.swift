//
//  BindingUpdateAction.swift
//  Weather - Redux
//
//  Created by Martin on 21.06.2021.
//

protocol BindingUpdateAction: Action {
    associatedtype ReduxState
    init(state: ReduxState)
    var state: ReduxState { get }
}
