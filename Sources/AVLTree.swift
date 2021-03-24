//
//  AVLTree.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/24.
//

import Foundation

class AVLNode<Element>: Identifiable {
    let id = UUID().uuidString
    var value: Element
    var left: AVLNode<Element>?
    var right: AVLNode<Element>?
    var height: Int = 0
    
    init(value: Element) {
        self.value = value
    }
    
    var leftHeight: Int {
        left?.height ?? -1
    }
    
    var rightHeight: Int {
        right?.height ?? -1
    }
    
    var balanceFactor: Int {
        leftHeight - rightHeight
    }
}

struct AVLTree<Element: Comparable> {
    private(set) var root: AVLNode<Element>?
    init() { }
}

extension AVLTree {
    mutating func insert(_ element: Element) {
        if contains(element) {
            return
        }
        root = insert(from: root, value: element)
    }
    
    private func insert(from node: AVLNode<Element>?, value: Element) -> AVLNode<Element> {
        guard let node = node else {
            return AVLNode(value: value)
        }
        
        if value < node.value {
            node.left = insert(from: node.left, value: value)
        } else {
            node.right = insert(from: node.right, value: value)
        }
        
        let balanceNode = balanced(node)
        balanceNode.height = max(balanceNode.leftHeight, balanceNode.rightHeight) + 1
        
        return balanceNode
    }
    
    private func leftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        let pivot = node.right!
        
        node.right = pivot.left
        
        pivot.left = node
        
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        
        return pivot
    }
    
    private func rightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        let pivot = node.left!
        
        node.left = pivot.right
        
        pivot.right = node
        
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        
        return pivot
    }
    
    private func rightLeftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let right = node.right else {
            return node
        }
        
        node.right = rightRotate(right)
        return leftRotate(node)
    }
    
    private func leftRightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let left = node.left else {
            return node
        }
        
        node.left = leftRotate(left)
        return rightRotate(node)
    }
    
    private func balanced(_ node: AVLNode<Element>) -> AVLNode<Element> {
        switch node.balanceFactor {
        case 2: /// 意味着left - right 过大，需要修改平衡left
            if let left = node.left, left.balanceFactor == -1 { /// right层次更多
                return leftRightRotate(node)
            } else {
                return rightRotate(node)
            }
        case -2: /// right过大
            if let right = node.right, right.balanceFactor == 1  {
                return rightLeftRotate(node)
            } else {
                return leftRotate(node)
            }
            
        default:
            return node
        }
    }
}

extension AVLTree {
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

private extension AVLNode {
    var min: AVLNode {
        return left?.min ?? self
    }
}

extension AVLTree {
    mutating func remove(_ value: Element) {
        root = remove(from: root, value: value)
    }
    
    private func remove(from node: AVLNode<Element>?, value: Element) -> AVLNode<Element>? {
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
        
        let balanceNode = balanced(node)
        balanceNode.height = max(balanceNode.leftHeight, balanceNode.rightHeight) + 1
        
        return balanceNode
    }
}
