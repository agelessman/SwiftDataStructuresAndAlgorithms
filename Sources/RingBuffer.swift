//
//  RingBuffer.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/23.
//

import Foundation

public struct RingBuffer<T> {
    private var array: [T?]
    private var readIndex = 0
    private var writeIndex = 0
    
    init(count: Int) {
        array = [T?](repeating: nil, count: count)
    }
    
    private var availableSpaceForReading: Int {
        writeIndex - readIndex
    }
    
    private var availableSpacingForWrite: Int {
        array.count - availableSpaceForReading
    }
    
    var isEmpty: Bool {
        availableSpaceForReading == 0
    }
    
    var isFull: Bool {
        availableSpacingForWrite == 0
    }
    
    var first: T? {
        if !isEmpty {
            return array[readIndex % array.count]
        } else {
            return nil
        }
    }
    
    var values: [T]? {
        if isEmpty {
            return nil
        }
        return array[readIndex..<writeIndex].compactMap {
            $0
        }
    }
    
    mutating func read() -> T? {
        if !isEmpty {
            let result = array[readIndex % array.count]
            readIndex += 1
            return result
        } else {
            return nil
        }
    }
    
    mutating func write(_ element: T) -> Bool {
        if !isFull {
            array[writeIndex % array.count] = element
            writeIndex += 1
            return true
        } else {
            return false
        }
    }
}
