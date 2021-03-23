//
//  BinaryTreeView.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/23.
//

import SwiftUI

class BinaryTreeViewModel: ObservableObject {
    @Published var tree = BinaryNode<Int>(value: 7)
    
    @Published var nodes: [BinaryNode<Int>] = []
    
    init() {
        let zero = BinaryNode(value: 0)
        let one = BinaryNode(value: 1)
        let five = BinaryNode(value: 5)
        let eight = BinaryNode(value: 8)
        let nine = BinaryNode(value: 9)
        tree.left = one
        one.left = zero
        one.right = five
        tree.right = nine
        nine.left = eight
    }
    
    func traverseInOrder() {
        var result: [BinaryNode<Int>] = []
        tree.traverseInOrder {
            result.append($0)
        }
        nodes = result
    }
    
    func traversePreOrder() {
        var result: [BinaryNode<Int>] = []
        tree.traversePreOrder {
            result.append($0)
        }
        nodes = result
    }
    
    func traversePostOrder() {
        var result: [BinaryNode<Int>] = []
        tree.traversePostOrder {
            result.append($0)
        }
        nodes = result
    }
}

struct BinaryTreeView: View {
    @StateObject var viewModel = BinaryTreeViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            BinaryDiagram(tree: viewModel.tree) { value in
                Text("\(value)")
                    .font(.caption2)
                    .foregroundColor(.primary)
                    .padding()
                    .background(Circle().foregroundColor(.green))
            }
            
            LazyHStack {
                ForEach(viewModel.nodes) { node in
                    Text("\(node.value)")
                        .font(.caption2)
                        .foregroundColor(.primary)
                        .padding(5)
                        .background(Capsule().foregroundColor(.orange))
                }
            }
            
            Button("traverseInOrder") {
                withAnimation {
                    viewModel.traverseInOrder()
                }
            }
            .padding(3)
            .cornerRadius(5)
            .border(Color.blue)

            
            Button("traversePreOrder") {
                withAnimation {
                    viewModel.traversePreOrder()
                }
            }
            .padding(3)
            .cornerRadius(5)
            .border(Color.blue)
            
            Button("traversePostOrder") {
                withAnimation {
                    viewModel.traversePostOrder()
                }
            }
            .padding(3)
            .cornerRadius(5)
            .border(Color.blue)

        }
    }
}

struct BinaryDiagram<A, V: View>: View {
    let tree: BinaryNode<A>
    let node: (A) -> V
    
    typealias Key = CollectDict<String, Anchor<CGPoint>>
    
    var children: [BinaryNode<A>] {
        var result: [BinaryNode<A>] = []
        
        if let left = tree.left {
            result.append(left)
        }
        
        if let right = tree.right {
            result.append(right)
        }
        
        return result
    }

    var body: some View {
        VStack(spacing: 10) {
            node(tree.value)
                .anchorPreference(key: Key.self, value: .center, transform: {
                    [self.tree.id: $0]
                })

            HStack(alignment: .top, spacing: 10) {
                ForEach(([tree.left] + [tree.right]).compactMap { $0 }) { child in
                    BinaryDiagram(tree: child, node: self.node)
                }
            }
        }
        .backgroundPreferenceValue(Key.self) { (centers: [String: Anchor<CGPoint>]) in
            GeometryReader { proxy in
                ForEach(children) { child in
                    Line(from: proxy[centers[self.tree.id]!],
                         to: proxy[centers[child.id]!])
                        .stroke()
                }
            }
        }
    }
}

struct BinaryTreeView_Previews: PreviewProvider {
    static var previews: some View {
        BinaryTreeView()
    }
}
