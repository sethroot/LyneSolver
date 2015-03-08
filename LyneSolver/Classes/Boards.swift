//
//  Boards.swift
//  LyneSolver
//
//  Created by Seth Root on 3/7/15.
//  Copyright (c) 2015 Seth Root. All rights reserved.
//

import Foundation

let ˍ = Node.Empty
let S = Node.Start
let o = Node.Node
let E = Node.End;

var board1:Board {
    
    var board = [
        [ˍ, ˍ, ˍ, ˍ],
        [S, ˍ, ˍ, E],
        [o, o, o, o],
        [ˍ, ˍ, ˍ, ˍ],
    ]
    return Matrix(values:board, gapValue: Node.Empty)
}

var board2:Board {
    
    var board = [
        [S,ˍ,ˍ,ˍ,ˍ,ˍ],
        [ˍ,o,ˍ,ˍ,ˍ,ˍ],
        [ˍ,o,o,ˍ,ˍ,ˍ],
        [ˍ,ˍ,o,o,ˍ,ˍ],
        [ˍ,ˍ,o,o,o,o],
        [ˍ,ˍ,ˍ,ˍ,ˍ,E],
    ]
    
    return Matrix(values:board, gapValue: Node.Empty)
}
