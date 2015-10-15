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
