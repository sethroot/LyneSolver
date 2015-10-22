//
//  LyneSolver.swift
//  LyneSolver
//
//  Created by Seth Root on 7/12/14.
//  Copyright (c) 2014 Seth Root. All rights reserved.
//

import Foundation


class LyneSolver {
    
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
        guard let startAddr = Node.Start.address(board) else {
            NSLog("Could not find starting node on the board")
            return
        }
        
        // Initialize Matrix of Bools to track which nodes have been processed
        let processed:Processed = Matrix(rows: board.rows, columns: board.columns, repeatedValue: false)
        
        // Generate a RoseTree of Directions with Node.Start as the root
        let trees:[RoseTree<Direction>] = treesForNode(board, addr:startAddr, processed:processed)
        
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
        
        // Filter paths that are not the correct length
        let lengthFiltered = paths.filter {$0.count == nodeCount}
        print("Filtered for length: ")
        
        for path in lengthFiltered {
            print(path)
        }
        print("")
        
        // Filter paths that do not end on Node.End
        let endAddress = Node.End.address(board)
        let endFiltered = lengthFiltered.filter {self.addressAtPathEnd(board, dirs: $0) == endAddress}
        print("Solutions: ")
        
        for path in endFiltered {
            print(path)
        }
    }
    
    func treesForNode(board:Board, addr:Address, var processed:Processed) -> [RoseTree<Direction>] {
        processed[addr.row, addr.col] = true
        
        var trees:[RoseTree<Direction>] = []
        
        for (direction, modRow, modCol) in directions {
            let neighborNode = addr.translate(modRow, modCol: modCol)
            
            if nodeExists(board, addr: neighborNode) && !processed[neighborNode.row, neighborNode.col] {
                trees.append(RoseTree.Node(direction, treesForNode(board, addr: neighborNode, processed: processed)))
            }
        }
        
        return trees
    }
    
    func nodeExists(board:Board, addr:Address) -> Bool {
        let (row, col) = (addr.row, addr.col)
        let node = board.indexIsValidForRow(row, column:col) ? board[row, col] : Node.Empty
        return node != Node.Empty
    }
    
    func addressAtPathEnd(board:Board, dirs:[Direction]) -> Address? {
        guard var node = Node.Start.address(board) else {
            return nil
        }
        
        for dir in dirs {
            let triple:DirModTriple = directions.filter {$0.direction == dir}[0]
            node = node.translate(triple.modRow, modCol: triple.modCol)
        }
        return node;
    }
}
