//
//  BinarySearch.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/26.
//

import Foundation

extension RandomAccessCollection where Element: Comparable {
    func binarySearch(for value: Element, in rang: Range<Index>?) -> Index? {
        let rang = rang ?? startIndex..<endIndex
        guard rang.lowerBound < rang.upperBound else {
            return nil
        }
        let size = distance(from: rang.lowerBound, to: rang.upperBound)
        let middle = index(rang.lowerBound, offsetBy: size / 2)
        
        if self[middle] == value {
            return middle
        } else if self[middle] > value {
            return binarySearch(for: value, in: rang.lowerBound..<middle)
        } else {
            return binarySearch(for: value, in: index(after: middle)..<rang.upperBound)
        }
    }
}
