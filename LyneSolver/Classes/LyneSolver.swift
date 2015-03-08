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
        
        println("Input:")
        println(board.description)
        println()
        
        // Find Address of Node.Start
        if let startNode:Address = addressessForNode(board, node: Node.Start) {
            
            // Initialize Matrix of Bools to track which nodes have been processed
            var processed:Processed = Matrix(rows: board.rows, columns: board.columns, repeatedValue: false)
            
            // Generate a RoseTree of Directions with Node.Start as the root
            let trees:[Box<DirTree>] = treesForNode(board, address:startNode, processed:processed)
            
            // Flatten each tree and accumulate
            var paths:DirMatrix = []
            trees.map {paths += $0.value.flatten()}
            
            println("All paths:")
            for path in paths {
                println(path)
            }
            println()
            
            // Count nodes
            var nodeCount:Int = 0;
            for node in board.grid {
                if (node == Node.Node || node == Node.End) {
                    nodeCount++;
                }
            }
            
            // Filter paths that are not the correct lenght
            var lengthFiltered = paths.filter {$0.count == nodeCount}
            println("Filtered for length: ")
            
            for path in lengthFiltered {
                println(path)
            }
            println()
            
            // Filter paths that do not end on Node.End
            var endAddress = addressessForNode(board, node: Node.End)
            var endFiltered = lengthFiltered.filter {self.addressAtPathEnd(board, dirs: $0) == endAddress}
            println("Solutions: ")
            
            for path in endFiltered {
                println(path)
            }
            
        } else {
            NSLog("Error! Could not find starting node on the board")
        }
    }
    
    func treesForNode(board:Board, address:Address, var processed:Processed) -> [Box<DirTree>] {
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
                treesForNode(board, address: neighborNode, processed: processed) : nil;
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
    
    func addressAtPathEnd(board:Board, dirs:DirList) -> Address? {
        var node:Address;
        
        if let startNode:Address = addressessForNode(board, node: Node.Start) {
            node = startNode
            for dir in dirs {
                var triple:DirModTriple = directions.filter {$0.direction == dir}[0]
                node = node.translate(triple.modRow, triple.modCol)
            }
            return node;
        }
        
        return nil;
    }
}