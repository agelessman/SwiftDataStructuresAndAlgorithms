//
//  Stack.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/19.
//

import Foundation

public struct Stack<Element> {
    private var storage: [Element] = []
    
    public init() {}
    
    public mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    public mutating func pop() -> Element? {
        return storage.popLast()
    }
}

extension Stack: CustomStringConvertible {
    public var description: String {
        let topDivider = "----top----\n"
        let bottomDivider = "\n----end----"
        
        let stackElements = storage
            .map { "\($0)" }
            .reversed()
            .joined(separator: "\n")
        return topDivider + stackElements + bottomDivider
    }
}
