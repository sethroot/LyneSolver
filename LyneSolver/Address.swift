//
//  Address.swift
//  LyneSolver
//
//  Created by Seth Root on 3/7/15.
//  Copyright (c) 2015 Seth Root. All rights reserved.
//

import Foundation

struct Address : Printable {
    let row:Int, col:Int
    var description: String {
        return "(\(row.description), \(col.description))"
    }
    init(row:Int, col:Int) {
        self.row = row
        self.col = col
    }
    func translate(modRow:AddressMod, modCol:AddressMod) -> Address {
        return Address(row:modRow(self.row), col:modCol(self.col))
    }
}
