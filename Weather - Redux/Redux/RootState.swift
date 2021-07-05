//
//  RootState.swift
//  Weather - Redux
//
//  Created by Martin on 05.07.2021.
//

import Foundation

protocol RootState: State {
    var deepcopy: Self { get }
}
