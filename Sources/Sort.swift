//
//  Sort.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/30.
//

import Foundation

func bubbleSort<Element>(_ array: inout [Element]) where Element: Comparable {
    guard array.count >= 2 else {
        return
    }
    
    for end in (1..<array.count).reversed() {
        var swapped = false
        
        for current in 0..<end {
            if array[current] > array[current + 1] {
                array.swapAt(current, current + 1)
                swapped = true
            }
        }
        
        if !swapped {
            return
        }
    }
}

func selectionSort<Element>(_ array: inout [Element]) where Element: Comparable {
    guard array.count >= 2 else {
        return
    }
    
    for current in 0..<(array.count - 1) {
        var lowest = current
        
        for other in (current + 1)..<array.count {
            if array[lowest] > array[other] {
                lowest = other
            }
        }
        
        if lowest != current {
            array.swapAt(current, lowest)
        }
    }
}

func insertionSort<Element>(_ array: inout [Element]) where Element: Comparable {
    guard array.count >= 2 else {
        return
    }
    
    for current in 1..<array.count {
        for shifting in (1...current).reversed() {
            if array[shifting] < array[shifting - 1] {
                array.swapAt(shifting, shifting - 1)
            } else {
                break
            }
        }
    }
}

func mergeSort<Element>(_ array: [Element]) -> [Element] where Element: Comparable {
    guard array.count > 1 else {
        return array
    }
    
    let middle = array.count / 2
    let left = mergeSort(Array(array[..<middle]))
    let right = mergeSort(Array(array[middle...]))
    return merge(left, right)
}

private func merge<Element>(_ left: [Element], _ right: [Element]) -> [Element] where Element: Comparable {
    var leftIndex = 0
    var rightIndex = 0
    
    var result: [Element] = []
    
    while leftIndex < left.count && rightIndex < right.count {
        let leftElement = left[leftIndex]
        let rightElement = right[rightIndex]
        if leftElement < rightElement {
            result.append(leftElement)
            leftIndex += 1
        } else if leftElement > rightElement {
            result.append(rightElement)
            rightIndex += 1
        } else {
            result.append(leftElement)
            leftIndex += 1
            result.append(rightElement)
            rightIndex += 1
        }
    }
    
    if leftIndex < left.count {
        result.append(contentsOf: left[leftIndex...])
    }
    
    if rightIndex < right.count {
        result.append(contentsOf: right[rightIndex...])
    }
    
    return result
}

extension Array where Element == Int {
    mutating func radixSort() {
        let base = 10
        var done = false
        var digits = 1
        
        while !done {
            done = true
            
            var buckets: [[Int]] = .init(repeating: [], count: base)
            
            forEach { number in
                let remainingPart = number / digits
                
                if remainingPart > 0 {
                    done = false
                }
                
                let digit = remainingPart % base
                buckets[digit].append(number)
            }
            
            digits *= base
            self = buckets.flatMap {
                $0
            }
        }
    }
}

extension Heap {
    func sorted() -> [Element] {
        var heap = Heap(sort: sort, elements: elements)
        for index in heap.elements.indices.reversed() {
            heap.elements.swapAt(0, index)
            heap.siftDown(from: 0, upTo: index)
        }
        return heap.elements
    }
}

func quickSortNaive<T: Comparable>(_ a: [T]) -> [T] {
    guard a.count > 1 else {
        return a
    }
    let pivot = a[a.count / 2]
    let less = a.filter { $0 < pivot }
    let more = a.filter { $0 > pivot }
    let equal = a.filter { $0 == pivot }
    return quickSortNaive(less) + equal + quickSortNaive(more)
}

func partitionLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
    let pivot = a[high]
    var i = low
    
    for j in low..<high {
        if a[j] <= pivot {
            a.swapAt(i, j)
            i += 1
        }
    }
    
    a.swapAt(i, high)
    
    return i
}

func quickSortLomulo<T: Comparable>(_ a: inout [T], low: Int, high: Int){
    if low < high {
        let pivot = partitionLomuto(&a, low: low, high: high)
        quickSortLomulo(&a, low: low, high: pivot - 1)
        quickSortLomulo(&a, low: pivot + 1, high: high)
    }
}

func partitionHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
    let pivot = a[low]
    var i = low - 1
    var j = high + 1
    while true {
        repeat { j -= 1 } while a[j] > pivot
        repeat { i += 1 } while a[i] < pivot
        
        if i < j {
            a.swapAt(i, j)
        } else {
            return j
        }
    }
}

func quickSortHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        let pivot = partitionHoare(&a, low: low, high: high)
        quickSortHoare(&a, low: low, high: pivot )
        quickSortHoare(&a, low: pivot + 1, high: high)
    }
}

/// 对pivot的优化，中位数
func medianOfThree<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
    let center = (low + high) / 2
    
    if a[low] > a[center] {
        a.swapAt(low, center)
    }
    if a[low] > a[high] {
        a.swapAt(low, high)
    }
    if a[center] > a[high] {
        a.swapAt(center, high)
    }
    return center
}

func quickSortMedian<T: Comparable>(_ a: inout [T], low: Int, high: Int){
    if low < high {
        let pivotIndex = medianOfThree(&a, low: low, high: high)
        a.swapAt(pivotIndex, high)
        let pivot = partitionLomuto(&a, low: low, high: high)
        quickSortLomulo(&a, low: low, high: pivot - 1)
        quickSortLomulo(&a, low: pivot + 1, high: high)
    }
}
