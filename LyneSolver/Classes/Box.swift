//
//  Box.swift
//  LyneSolver
//
//  Created by Seth Root on 3/5/15.
//  Copyright (c) 2015 Seth Root. All rights reserved.
//

import Foundation

public final class Box<T> {
    private let _value : () -> T
    
    public init(_ value : T) {
        self._value = { value }
    }
    
    public var value: T {
        return _value()
    }
}
