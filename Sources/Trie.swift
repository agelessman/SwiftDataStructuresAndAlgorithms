//
//  Trie.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/25.
//

import Foundation

class Trie<CollectionType: Collection> where CollectionType.Element: Hashable {
    typealias Node = TrieNode<CollectionType.Element>
    
    let root = Node(key: nil, parent: nil)
    
    init() { }
}

extension Trie {
    func insert(_ collection: CollectionType) {
        var current = root
        
        for element in collection {
            if current.children[element] == nil {
                current.children[element] = Node(key: element, parent: current)
            }
            
            current = current.children[element]!
        }
        
        current.isTerminating = true
    }
}

extension Trie {
    func contains(_ collection: CollectionType) -> Bool {
        var current = root
        
        for element in collection {
            guard let child = current.children[element] else {
                return false
            }
            
            current = child
        }
        
        return current.isTerminating
    }
}

extension Trie {
    func remove(_ collection: CollectionType) {
        var current = root
        
        /// 找到最后的node
        for element in collection {
            guard let child = current.children[element] else {
                return
            }
            
            current = child
        }
        
        current.isTerminating = false
        
        /// 删除多余的node
        while let parent = current.parent, current.children.isEmpty && !current.isTerminating {
            parent.children[current.key!] = nil
            current = parent
        }
    }
}

extension Trie where CollectionType: RangeReplaceableCollection {
    func collections(startingWith prefix: CollectionType) -> [CollectionType] {
        var current = root
        
        for element in prefix {
            guard let child = current.children[element] else {
                return []
            }
            current = child
        }
        
        return collections(startingWith: prefix, after: current)
    }
    
    private func collections(startingWith prefix: CollectionType, after node: Node) -> [CollectionType] {
        var result: [CollectionType] = []
        
        if node.isTerminating {
            result.append(prefix)
        }
        
        for child in node.children.values {
            var prefix = prefix
            prefix.append(child.key!)
            result.append(contentsOf: collections(startingWith: prefix, after: child))
        }
        
        return result
    }
}
