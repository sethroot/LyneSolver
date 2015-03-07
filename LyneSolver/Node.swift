//
//  Node.swift
//  LyneSolver
//
//  Created by Seth Root on 3/7/15.
//  Copyright (c) 2015 Seth Root. All rights reserved.
//

import Foundation

enum Node : String, Printable {
    case Empty = "_"
    case Start = "S"
    case Node = "o"
    case End = "E"
    
    var description: String {
        return self.rawValue
    }
}
