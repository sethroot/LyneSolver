//
//  Node.swift
//  LyneSolver
//
//  Created by Seth Root on 3/7/15.
//  Copyright (c) 2015 Seth Root. All rights reserved.
//

import Foundation

enum Node : String, CustomStringConvertible {
    case Empty = "ˍ"
    case Start = "S"
    case Node = "o"
    case End = "E"
    
    var description: String {
        return self.rawValue
    }
    
    func address(board:Board) -> Address? {
        for var i=0; i<board.rows; i++ {
            for var j=0; j<board.columns; j++ {
                if board[i,j] == self {
                    return Address(row: i, col: j)
                }
            }
        }
        
        return nil
    }
}
