//
//  HeapView.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/26.
//

import SwiftUI

struct HeapView: View {
    @State var tree = BinarySearchTree<Int>()
    @State var heap = Heap<Int>(sort: >, elements: [1,12,3,4,6,8,7, 15, 32, 44, 45, 55])
    @State var insertText = ""
    
    var body: some View {
        VStack(spacing: 20) {
            if tree.root != nil {
                BinaryDiagram(tree: tree.root!) { value in
                    Text("\(value)")
                        .font(.caption2)
                        .foregroundColor(.primary)
                        .padding()
                        .background(Circle().foregroundColor(.green))
                }
                .animation(.easeInOut)
            }
            
            HStack {
                Button("删除") {
                    _ = heap.remove()
                    calculate()
                }
            }
            .padding(.horizontal, 10)

            HStack {
                Text("删除第i位置")
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<heap.count, id: \.self) { index in
                            Button("\(index)") {
                                _ = heap.remove(at: index)
                                calculate()
                            }
                            .padding()
                            .background(Circle().foregroundColor(.green))
                        }
                    }
                }
            }
            .padding(.horizontal, 10)

            HStack {
                TextField("请输入要插入的数字", text: $insertText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)

                Button("确定") {
                    if let numer = Int(insertText) {
                        heap.insert(numer)
                        calculate()
                    }
                }

            }
            .padding(.horizontal, 10)

            Spacer()
        }
        .onAppear {
            calculate()
        }
    }
    
    func calculate() {
        var nodes: [BinaryNode<Int>] = []
        for i in 0..<heap.count {
            let node = BinaryNode<Int>(value: heap.element(at: i)!)
            nodes.append(node)
        }
        for i in 0..<nodes.count {
            let node = nodes[i]
            let leftIndex = heap.leftChildIndex(ofParentAt: i)
            let rightIndex = heap.rightChildIndex(ofParentAt: i)
            if leftIndex < nodes.count {
                node.left = nodes[leftIndex]
            }
            if rightIndex < nodes.count {
                node.right = nodes[rightIndex]
            }
        }
    
        tree = BinarySearchTree(root: nodes.first)
    }
}


struct HeapView_Previews: PreviewProvider {
    static var previews: some View {
        HeapView()
    }
}
