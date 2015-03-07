//
//  Boards.swift
//  LyneSolver
//
//  Created by Seth Root on 3/7/15.
//  Copyright (c) 2015 Seth Root. All rights reserved.
//

import Foundation

var board1:Board {
    var b = Matrix(rows: 4, columns: 4, repeatedValue: Node.Empty)
    b[1,0] = Node.Start
    b[1,3] = Node.End
    b[2,0] = Node.Node
    b[2,1] = Node.Node
    b[2,2] = Node.Node
    b[2,3] = Node.Node
    return b
}

var board2:Board {
    var b = Matrix(rows: 6, columns: 6, repeatedValue: Node.Empty)
    b[0,0] = Node.Start
    b[5,5] = Node.End
    b[1,1] = Node.Node
    b[2,2] = Node.Node
    b[2,3] = Node.Node
    b[3,3] = Node.Node
    b[3,4] = Node.Node
    b[3,5] = Node.Node
    b[4,5] = Node.Node
    return b
}
