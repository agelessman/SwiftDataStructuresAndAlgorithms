//
//  Tree.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/22.
//

import Foundation

class TreeNode<T>: Identifiable {
    let id = UUID().uuidString
    var value: T
    var children: [TreeNode] = []
    
    init(_ value: T) {
        self.value = value
    }
}

extension TreeNode {
    func add(_ node: TreeNode) {
        children.append(node)
    }
}

extension TreeNode {
    func forEachDepthFirst(visit: (TreeNode) -> Void) {
        visit(self)
        children.forEach { $0.forEachDepthFirst(visit: visit) }
    }
}


extension TreeNode {
    struct Queue<T> {
        private var storage: [T] = []
        
        mutating func enqueue(_ node: T) {
            storage.append(node)
        }
        
        mutating func dequeue() -> T? {
            return storage.isEmpty ? nil : storage.removeFirst()
        }
    }
    
    func forEachLevelOrder(visit: (TreeNode) -> Void) {
        visit(self)
        var queue = Queue<TreeNode>()
        children.forEach { queue.enqueue($0) }
        while let node = queue.dequeue() {
            visit(node)
            node.children.forEach { queue.enqueue($0) }
        }
    }
}

extension TreeNode where T: Equatable {
    func search(_ value: T) -> TreeNode<T>? {
        var result: TreeNode?
        forEachDepthFirst { node in
            if node.value == value {
                result = node
            }
        }
        return result;
    }
}

