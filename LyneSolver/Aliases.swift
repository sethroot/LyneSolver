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

typealias DirTree = RoseTree<(Direction)>
typealias DirMatrix = [[Direction]]
typealias DirList = [Direction]
typealias DirModTriple = (Direction, AddressMod, AddressMod)
