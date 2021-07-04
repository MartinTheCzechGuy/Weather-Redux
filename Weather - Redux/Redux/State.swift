//
//  State.swift
//  Weather - Redux
//
//  Created by Martin on 21.06.2021.
//

protocol State: AnyObject {
    associatedtype ReduxStore: Store
    var deepcopy: Self { get }
    
    func initialize(store: ReduxStore)
}
