//
//  TrieNode.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/25.
//

import Foundation

class TrieNode<Key: Hashable>: Identifiable {
    let id = UUID().uuidString
    var key: Key?
    weak var parent: TrieNode<Key>?
    var children: [Key: TrieNode] = [:]
    var isTerminating = false
    
    init(key: Key?, parent: TrieNode?) {
        self.key = key
        self.parent = parent
    }
}

