//
//  Direction.swift
//  LyneSolver
//
//  Created by Seth Root on 3/7/15.
//  Copyright (c) 2015 Seth Root. All rights reserved.
//

import Foundation

enum Direction : String, CustomStringConvertible {
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