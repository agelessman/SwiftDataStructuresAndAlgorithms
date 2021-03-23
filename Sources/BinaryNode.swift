//
//  BinaryNode.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/23.
//

import Foundation

public class BinaryNode<Element>: Identifiable {
    public let id = UUID().uuidString
    var value: Element
    var left: BinaryNode?
    var right: BinaryNode?
    
    init(value: Element) {
        self.value = value
    }
    
    func traverseInOrder(visit: (BinaryNode) -> Void) {
        left?.traverseInOrder(visit: visit)
        visit(self)
        right?.traverseInOrder(visit: visit)
    }
    
    func traversePreOrder(visit: (BinaryNode) -> Void) {
        visit(self)
        left?.traversePreOrder(visit: visit)
        right?.traversePreOrder(visit: visit)
    }
    
    func traversePostOrder(visit: (BinaryNode) -> Void) {
        left?.traversePostOrder(visit: visit)
        right?.traversePostOrder(visit: visit)
        visit(self)
    }
}
