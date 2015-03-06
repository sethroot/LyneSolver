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
    
    typealias Row = Int
    typealias Col = Int
    typealias Board = Matrix<Node>
    typealias Processed = Matrix<Bool>
    typealias AddrMod = (Int -> Int)
    
    
    typealias DirTree = RoseTree<(Direction)>
    typealias DirMatrix = [[Direction]]
    typealias DirList = [Direction]
    typealias DirModTriple = (Direction, AddrMod, AddrMod)
    
    enum Node : String, Printable {
        case Empty = "_"
        case Start = "S"
        case Node = "o"
        case End = "E"
        
        var description: String {
            return self.rawValue
        }
    }

    enum Direction : String, Printable {
        case Up = "up"
        case Down = "down"
        case Left = "left"
        case Right = "right"
        case UpLeft = "upLeft"
        case UpRight = "upRight"
        case DownLeft = "downLeft"
        case DownRight = "downRight"
        
        var description: String {
            return self.rawValue
        }
    }
    
    struct Addr : Printable {
        let row:Int, col:Int
        var description: String {
        return "(\(row.description), \(col.description))"
        }
        init(row:Int, col:Int) {
            self.row = row
            self.col = col
        }
        func translate(modRow:AddrMod, modCol:AddrMod) -> Addr {
            return Addr(row:modRow(self.row), col:modCol(self.col))
        }
    }
    
    var dirs:[DirModTriple] {
    
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
    
    var board:Board {
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
    
    var processed:Processed {
        return Matrix(rows: 6, columns: 6, repeatedValue: false)
    }
    
    func main() {
        solveBoard(board);
        solveBoard(board2);
    }
    
    func solveBoard(board:Board) {
        println(board.description)
        if let startNode:Addr = addressForNode(board, node: Node.Start) {
            let trees:[Box<DirTree>] = findTreesForNode(board, addr:startNode, processed:processed)
            
            for tree in trees {
                var matrix:DirMatrix = tree.value.flatten()
                //println("source: " + tree.value.description)
                for path in matrix {
                    println(path)
                }
            }
            println()
        } else {
            NSLog("Error! Could not find starting node on the board")
        }
    }
    
    func addressForNode(board:Board, node:Node) -> Addr? {
        for var i=0; i<board.rows; i++ {
            for var j=0; j<board.columns; j++ {
                let n:Node = board[i,j]
                if n == node {
                    return Addr(row: i, col: j)
                }
            }
        }
        
        return nil
    }

    func findTreesForNode(board:Board, addr:Addr, var processed:Processed) -> [Box<DirTree>] {
        let (row, col) = (addr.row, addr.col)
        processed[row, col] = true
        
        let nodeExists = {(addr:Addr) -> Bool in
            let (row, col) = (addr.row, addr.col)
            let node = board.indexIsValidForRow(row, column:col) ? board[row, col] : Node.Empty
            return node != Node.Empty
        }
        
        func generatePaths(modRow:AddrMod, modCol:AddrMod) -> [Box<DirTree>]? {
            let neighborNode:Addr = addr.translate(modRow, modCol: modCol)
            
            return nodeExists(neighborNode) && !processed[neighborNode.row, neighborNode.col] ?
                findTreesForNode(board, addr: neighborNode, processed: processed) : nil;
        }
        
        var trees:[Box<DirTree>] = []
        for (direction, modRow, modCol) in dirs {
            if let paths = generatePaths(modRow, modCol) {
                trees.append(Box(RoseTree.Node(Box(direction), paths)))
            }
        }
        
        return trees
    }
    
    
}