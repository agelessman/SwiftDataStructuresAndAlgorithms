//
//  TreeView.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/22.
//

import SwiftUI

class TreeViewModel: ObservableObject {
    @Published var tree = TreeNode<String>("李至叻")
    
    @Published var nodes: [TreeNode<String>] = []
    
    init() {
        let node1 = TreeNode("李福来")
        let node2 = TreeNode("李福报")
        let node3 = TreeNode("李美伊")
        
        tree.add(node1)
        tree.add(node2)
        tree.add(node3)
        
        let node21 = TreeNode("李林山")
        let node22 = TreeNode("李林海")
        let node23 = TreeNode("李铁人")
        node2.add(node21)
        node2.add(node22)
        node2.add(node23)

        let node31 = TreeNode("林金水")
        let node32 = TreeNode("林细雨")
        node3.add(node31)
        node3.add(node32)

        let node221 = TreeNode("杨盼回")
        let node222 = TreeNode("杨汪洋")
        let node223 = TreeNode("杨王东")
        node22.add(node221)
        node22.add(node222)
        node22.add(node223)
        
    }
    
    func depthFirst() {
        var result = [TreeNode<String>]()
        tree.forEachDepthFirst(visit: {
            result.append($0)
        })
        nodes = result
    }
    
    func levelOrder() {
        var result = [TreeNode<String>]()
        tree.forEachLevelOrder(visit: {
            result.append($0)
        })
        nodes = result
    }
}

struct TreeView: View {
    @StateObject private var viewModel = TreeViewModel()
    
    
    var body: some View {
        VStack(spacing: 20) {
            Diagram(tree: viewModel.tree) { value in
                Text("\(value)")
                    .font(.caption2)
                    .foregroundColor(.primary)
                    .padding(5)
                    .background(Color.green)
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
            
            Button("depthFirst") {
                withAnimation {
                    viewModel.depthFirst()
                }
            }
            .padding(3)
            .cornerRadius(5)
            .border(Color.blue)

            
            Button("levelOrder") {
                withAnimation {
                    viewModel.levelOrder()
                }
            }
            .padding(3)
            .cornerRadius(5)
            .border(Color.blue)

        }
    }
}

struct Diagram<A, V: View>: View {
    let tree: TreeNode<A>
    let node: (A) -> V

    typealias Key = CollectDict<String, Anchor<CGPoint>>

    var body: some View {
        VStack(spacing: 10) {
            node(tree.value)
                .anchorPreference(key: Key.self, value: .center, transform: {
                    [self.tree.id: $0]
                })

            HStack(alignment: .top, spacing: 10) {
                ForEach(tree.children) { child in
                    Diagram(tree: child, node: self.node)
                }
            }
        }
        .backgroundPreferenceValue(Key.self) { (centers: [String: Anchor<CGPoint>]) in
            GeometryReader { proxy in
                ForEach(self.tree.children) { child in
                    Line(from: proxy[centers[self.tree.id]!],
                         to: proxy[centers[child.id]!])
                        .stroke()
                }
            }
        }
    }
}

struct CollectDict<Key: Hashable, Value>: PreferenceKey {
    static var defaultValue: [Key: Value] { [:] }
    static func reduce(value: inout [Key: Value], nextValue: () -> [Key: Value]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

struct Line: Shape {
    var from: CGPoint
    var to: CGPoint

    var animatableData: AnimatablePair<CGPoint, CGPoint> {
        get {
            AnimatablePair(from, to)
        }
        set {
            from = newValue.first
            to = newValue.second
        }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: from)
        path.addLine(to: to)

        return path
    }
}

extension CGPoint: VectorArithmetic {
    public static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    public mutating func scale(by rhs: Double) {
        x *= CGFloat(rhs)
        y *= CGFloat(rhs)
    }

    public var magnitudeSquared: Double {
        0
    }

    public static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

struct TreeView_Previews: PreviewProvider {
    static var previews: some View {
        TreeView()
    }
}
