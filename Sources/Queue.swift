//
//  Queue.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/19.
//

import Foundation

public protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
}

public struct QueueArray<T>: Queue {
    private var array: [T] = []
    public init() {}
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var peek: T? {
        return array.first
    }
    
    public mutating func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }
    
    public mutating func dequeue() -> T? {
        return isEmpty ? nil : array.removeFirst()
    }
    
    var values: [T] {
        return array
    }
}

public struct QueueDoublyLinkedList<T>: Queue {
    private var linkedList = DoublyLinkedList<T>()
    
    public init() {}
    
    public var isEmpty: Bool {
        linkedList.isEmpty
    }
    
    public var peek: T? {
        linkedList.first?.value
    }
    
    public func enqueue(_ element: T) -> Bool {
        linkedList.append(element)
        return true
    }
    
    public func dequeue() -> T? {
        return linkedList.isEmpty ? nil : linkedList.remove(linkedList.head!)
    }
    
    var values: [T] {
        var result = [T]()
        linkedList.forEach {
            result.append($0.value)
        }
        return result
    }
}

public struct QueueRingBuffer<T>: Queue {
    private var ringBuffer: RingBuffer<T>
    
    init(count: Int) {
        ringBuffer = RingBuffer<T>(count: count)
    }
    
    public var isEmpty: Bool {
        ringBuffer.isEmpty
    }
    
    public var peek: T? {
        ringBuffer.first
    }
    
    public mutating func enqueue(_ element: T) -> Bool {
        ringBuffer.write(element)
    }
    
    public mutating func dequeue() -> T? {
        ringBuffer.read()
    }
    
    var values: [T]? {
        ringBuffer.values
    }
}
