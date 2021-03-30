//
//  BinarySearchTree.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/23.
//

import Foundation

struct BinarySearchTree<Element: Comparable> {
    private(set) var root: BinaryNode<Element>?
    init(root: BinaryNode<Element>? = nil) { self.root = root }
}

extension BinarySearchTree {
    mutating func insert(_ element: Element) {
        if contains(element) {
            return
        }
        root = insert(from: root, value: element)
    }
    
    private func insert(from node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element> {
        guard let node = node else {
            return BinaryNode(value: value)
        }
        
        if value < node.value {
            node.left = insert(from: node.left, value: value)
        } else {
            node.right = insert(from: node.right, value: value)
        }
        
        return node
    }
}

extension BinarySearchTree {
    func contains(_ value: Element) -> Bool {
        var current = root
        
        while let node = current {
            if node.value == value {
                return true
            }
            
            if value < node.value {
                current = node.left
            } else {
                current = node.right
            }
        }
        
        return false
    }
}

private extension BinaryNode {
    var min: BinaryNode {
        return left?.min ?? self
    }
}

extension BinarySearchTree {
    mutating func remove(_ value: Element) {
        root = remove(from: root, value: value)
    }
    
    private func remove(from node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element>? {
        guard let node = node else {
            return nil
        }
        
        if value == node.value {
            if node.left == nil && node.right == nil {
                return nil
            }
            if node.left == nil {
                return node.right
            }
            if node.right == nil {
                return node.left
            }
            
            node.value = node.right!.min.value
            node.right = remove(from: node.right, value: node.value)
        } else if value < node.value {
            node.left = remove(from: node.left, value: value)
        } else {
            node.right = remove(from: node.right, value: value)
        }
        return node
    }
}
