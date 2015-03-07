//
//  LyneSolver.swift
//  LyneSolver
//
//  Created by Seth Root on 7/12/14.
//  Copyright (c) 2014 Seth Root. All rights reserved.
//

import Foundation

@objc
class LyneSolver {
    
    var directions:[DirModTriple] {
        
        func id(i:Int) -> Int {return i}
        func inc(i:Int) -> Int {return i+1}
        func dec(i:Int) -> Int {return i-1}
        
        return [
            (Direction.Up, dec, id),
            (Direction.Down, inc, id),
            (Direction.Left, id, dec),
            (Direction.Right, id, inc),
            (Direction.UpLeft, dec, dec),
            (Direction.UpRight, dec, inc),
            (Direction.DownLeft, inc, dec),
            (Direction.DownRight, inc, inc)
        ]
    }
    
    func main() {
        solveBoard(board1);
        println()
        
        solveBoard(board2);
        println()
    }
    
    func solveBoard(board:Board) {
        
        println(board.description)
        
        // Find start node
        if let startNode:Address = addressessForNode(board, node: Node.Start) {
            
            // Initialize matrix to track which nodes have been processed
            var processed:Processed = Matrix(rows: board.rows, columns: board.columns, repeatedValue: false)
            
            // Generate a RoseTree of Directions with Node.Start as the root
            let trees:[Box<DirTree>] = findTreesForNode(board, address:startNode, processed:processed)
            
            // Flatten each tree and accumulate
            var paths:DirMatrix = []
            trees.map {paths += $0.value.flatten()}
            
            for path in paths {
                println(path)
            }
            
        } else {
            NSLog("Error! Could not find starting node on the board")
        }
    }
    
    func findTreesForNode(board:Board, address:Address, var processed:Processed) -> [Box<DirTree>] {
        let (row, col) = (address.row, address.col)
        processed[row, col] = true
        
        let nodeExists = {(address:Address) -> Bool in
            let (row, col) = (address.row, address.col)
            let node = board.indexIsValidForRow(row, column:col) ? board[row, col] : Node.Empty
            return node != Node.Empty
        }
        
        func generatePaths(modRow:AddressMod, modCol:AddressMod) -> [Box<DirTree>]? {
            let neighborNode:Address = address.translate(modRow, modCol: modCol)
            
            return nodeExists(neighborNode) && !processed[neighborNode.row, neighborNode.col] ?
                findTreesForNode(board, address: neighborNode, processed: processed) : nil;
        }
        
        var trees:[Box<DirTree>] = []
        for (direction, modRow, modCol) in directions {
            if let paths = generatePaths(modRow, modCol) {
                trees.append(Box(RoseTree.Node(Box(direction), paths)))
            }
        }
        
        return trees
    }
    
    func addressessForNode(board:Board, node:Node) -> Address? {
        for var i=0; i<board.rows; i++ {
            for var j=0; j<board.columns; j++ {
                let n:Node = board[i,j]
                if n == node {
                    return Address(row: i, col: j)
                }
            }
        }
        
        return nil
    }
}