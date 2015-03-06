//
//  RoseTree.swift
//  LyneSolver
//
//  Created by Seth Root on 3/5/15.
//  Copyright (c) 2015 Seth Root. All rights reserved.
//

import Foundation

enum RoseTree<T> : Printable {
    case Node (Box<T>, [Box<RoseTree<T>>])
    
    var description: String {
        var desc:String = ""
        switch self {
        case .Node(let val, let trees):
            desc += "\(val.value)"
            desc += trees.count > 0 ? " " : ""
            for tree in trees {
                desc += "[\(tree.value.description)]"
            }
        }
        return desc
    }
    
    func flatten() -> [[T]] {
        var acc:[[T]] = []
        flattenHelper(self, acc: &acc)
        return acc
    }
    
    func flattenHelper(tree:RoseTree<T>, inout acc:[[T]]) -> ([[T]]?, [T]?) {
        switch tree {
        case .Node(let val, let trees):
            
            if trees.count == 0 {
                return (nil, [val.value])
            }
            
            for tree in trees {
                var acc2:[[T]] = [];
                var (_, leaf) = flattenHelper(tree.value, acc:&acc2)
                
                if leaf != nil {
                    leaf!.insert(val.value, atIndex: 0);
                    acc2.insert(leaf!, atIndex: 0)
                } else {
                    for (index, dir) in enumerate(acc2) {
                        acc2[index].insert(val.value, atIndex: 0)
                    }
                }
                
                acc += acc2
            }
        }
        
        return (acc, nil)
    }
}
