//
//  LyneSolver.swift
//  LyneSolver
//
//  Created by Seth Root on 7/12/14.
//  Copyright (c) 2014 Seth Root. All rights reserved.
//

import Foundation


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
        print("")
        
        solveBoard(board2);
        print("")
    }
    
    func solveBoard(board:Board) {
        
        print("Input:")
        print(board.description)
        print("")
        
        // Find Address of Node.Start
        if let startNode:Address = addressessForNode(board, node: Node.Start) {
            
            // Initialize Matrix of Bools to track which nodes have been processed
            let processed:Processed = Matrix(rows: board.rows, columns: board.columns, repeatedValue: false)
            
            // Generate a RoseTree of Directions with Node.Start as the root
            let trees:[RoseTree<Direction>] = treesForNode(board, addr:startNode, processed:processed)
            
            // Flatten each tree and accumulate
            var paths:[[Direction]] = []
            for tree in trees {
                paths += tree.flatten()
            }
            
            print("All paths:")
            for path in paths {
                print(path)
            }
            print("")
            
            // Count nodes
            var nodeCount:Int = 0;
            for node in board.grid {
                if (node == Node.Node || node == Node.End) {
                    nodeCount++;
                }
            }
            
            // Filter paths that are not the correct lenght
            let lengthFiltered = paths.filter {$0.count == nodeCount}
            print("Filtered for length: ")
            
            for path in lengthFiltered {
                print(path)
            }
            print("")
            
            // Filter paths that do not end on Node.End
            let endAddress = addressessForNode(board, node: Node.End)
            let endFiltered = lengthFiltered.filter {self.addressAtPathEnd(board, dirs: $0) == endAddress}
            print("Solutions: ")
            
            for path in endFiltered {
                print(path)
            }
            
        } else {
            NSLog("Could not find starting node on the board")
        }
    }
    
    func treesForNode(board:Board, addr:Address, var processed:Processed) -> [RoseTree<Direction>] {
        let (row, col) = (addr.row, addr.col)
        
        processed[row, col] = true
        
        func generatePaths(modRow:AddressMod, modCol:AddressMod) -> [RoseTree<Direction>]? {
            let neighborNode:Address = addr.translate(modRow, modCol: modCol)
            
            if nodeExists(board, addr:neighborNode) && !processed[neighborNode.row, neighborNode.col] {
                return treesForNode(board, addr: neighborNode, processed: processed)
            } else {
                return nil
            }
        }

        var trees:[RoseTree<Direction>] = []
        
        for (direction, modRow, modCol) in directions {
            if let paths = generatePaths(modRow, modCol: modCol) {
                trees.append(RoseTree.Node(direction, paths))
            }
        }
        
        return trees
    }
    
    func nodeExists(board:Board, addr:Address) -> Bool {
        let (row, col) = (addr.row, addr.col)
        let node = board.indexIsValidForRow(row, column:col) ? board[row, col] : Node.Empty
        return node != Node.Empty
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
    
    func addressAtPathEnd(board:Board, dirs:[Direction]) -> Address? {
        var node:Address;
        
        if let startNode:Address = addressessForNode(board, node: Node.Start) {
            node = startNode
            for dir in dirs {
                let triple:DirModTriple = directions.filter {$0.direction == dir}[0]
                node = node.translate(triple.modRow, modCol: triple.modCol)
            }
            return node;
        }
        
        return nil;
    }
}