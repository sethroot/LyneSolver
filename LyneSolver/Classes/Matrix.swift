//
//  Matrix.swift
//  LyneSolver
//
//  Created by Seth Root on 3/5/15.
//  Copyright (c) 2015 Seth Root. All rights reserved.
//

import Foundation

struct Matrix<T:CustomStringConvertible> : CustomStringConvertible {
    
    let rows: Int, columns: Int
    
    internal var grid: [T]
    
    var description: String {
        var desc:String = "["
        for var i=0; i<self.rows; i++ {
            if i > 0 {
                desc += " "
            }
            desc += "["
            for var j=0; j<self.columns; j++ {
                desc += self[i,j].description
                if j < self.rows - 1 {
                    desc += ","
                }
            }
            if i == self.rows - 1 {
                desc += "]"
            } else {
                desc += "],\n"
            }
        }
        desc += "]"
        return desc
    }
    
    init(rows: Int, columns: Int, repeatedValue:T) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: repeatedValue)
    }
    
    init(values:[[T]], gapValue:T) {
        self.rows = values.count
        self.columns = values.reduce(0) {max($0, $1.count)}
        
        grid = Array<T>();
        for rIndex in 0...self.rows - 1 {
            for cIndex in 0...self.columns - 1 {
                grid.insert(values[rIndex][cIndex], atIndex: (rIndex * self.columns) + cIndex)
            }
        }
    }
    
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> T {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}
