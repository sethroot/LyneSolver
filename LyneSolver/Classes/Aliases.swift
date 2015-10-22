//
//  Aliases.swift
//  LyneSolver
//
//  Created by Seth Root on 3/7/15.
//  Copyright (c) 2015 Seth Root. All rights reserved.
//

import Foundation

typealias Board = Matrix<Node>
typealias Processed = Matrix<Bool>
typealias AddressMod = (Int -> Int)
typealias DirModTriple = (direction: Direction, modRow: AddressMod, modCol: AddressMod)
