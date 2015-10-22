//
//  RoseTree.swift
//  LyneSolver
//
//  Created by Seth Root on 3/5/15.
//  Copyright (c) 2015 Seth Root. All rights reserved.
//

import Foundation

enum RoseTree<T> : CustomStringConvertible {
    indirect case Node (T, [RoseTree<T>])
    
    var description: String {
        var desc:String = ""
        switch self {
        case .Node(let val, let trees):
            desc += "\(val)"
            desc += trees.count > 0 ? " " : ""
            for tree in trees {
                desc += "[\(tree.description)]"
            }
        }
        return desc
    }
    
    // Flatten the tree to a 2 dimensional array of T, where each inner array
    // contains the values from the root node to a unique leaf
    func flatten() -> [[T]] {
        var acc:[[T]] = []
        flattenHelper(self, acc: &acc)
        return acc
    }
    
    func flattenHelper(tree:RoseTree<T>, inout acc:[[T]]) -> ([[T]]?, [T]?) {
        switch tree {
        case .Node(let val, let trees):
            
            // Leaf case
            if trees.count == 0 {
                // Return the leaf value in an Array that will be used to collect all the values above it in the tree
                return (nil, [val])
            }
            
            // Tree case
            for tree in trees {
                
                // Each tree may continue to branch, so create a new 2 dimensional accumulator
                var treeAcc:[[T]] = [];
                
                // Recursively flatten the tree using the new accumulator
                let (_, leaf) = flattenHelper(tree, acc:&treeAcc)
                
                // If the recursion produced a leaf
                if var leaf = leaf {
                    
                    // Insert the value of this node at the 0 position
                    leaf.insert(val, atIndex: 0)
                    
                    // Then add the leaf to the tree's accumulator
                    treeAcc.insert(leaf, atIndex: 0)
                } else {
                    
                    // Otherwise add the value of this node to each subtree that was created
                    for (index, _) in treeAcc.enumerate() {
                        treeAcc[index].insert(val, atIndex: 0)
                    }
                }
                
                // Append the tree accumulator to the parameter accumulator
                acc += treeAcc
            }
        }
        
        return (acc, nil)
    }
}
