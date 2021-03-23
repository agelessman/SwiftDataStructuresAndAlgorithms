//
//  DoublyLInkedList.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/23.
//

import Foundation

public class DoublyLinkedList<T> {
    public var head: Node<T>?
    public var tail: Node<T>?
    
    init() {
        
    }
    
    public var isEmpty: Bool {
        head == nil
    }
    
    public var first: Node<T>? {
        head
    }
    
    public func append(_ value: T) {
        let newNode = Node(value: value)
        
        guard let tailNode = tail else {
            head = newNode
            tail = newNode
            return
        }
        
        tailNode.next = newNode
        newNode.previous = tailNode
        tail = newNode
    }
    
    public func remove(_ node: Node<T>) -> T {
        let next = node.next
        let previous = node.previous
        
        if let previous = previous {
            previous.next = next
        } else {
            head = next
        }
        
        next?.previous = previous
        
        if next == nil {
            tail = previous
        }
        
        node.previous = nil
        node.next = nil
        
        return node.value
    }
}

public class DoublyLinkedListIterator<T>: IteratorProtocol {
    private var currentNode: Node<T>?
    
    init(node: Node<T>?) {
        self.currentNode = node
    }
    
    public func next() -> Node<T>? {
        defer {
            currentNode = currentNode?.next
        }
        return currentNode
    }
}

extension DoublyLinkedList: Sequence {
    public func makeIterator() -> DoublyLinkedListIterator<T> {
        DoublyLinkedListIterator(node: head)
    }
}
