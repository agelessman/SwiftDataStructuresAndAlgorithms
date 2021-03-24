//
//  AVLTreeView.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/24.
//

import SwiftUI
import Combine

class AVLTreeViewModel: ObservableObject {
    @Published var tree = AVLTree<Int>()
    
    @Published var nodes: [AVLNode<Int>] = []
    
    @Published var inputText = ""
    
    @Published var contains = false
    
    @Published var removeText = ""
    
    var anyCancellables = Set<AnyCancellable>()
    
    init() {
        tree.insert(30)
        tree.insert(15)

        tree.insert(40)
        tree.insert(35)
        tree.insert(60)
        tree.insert(45)
        tree.insert(70)

        
        $inputText
            .map { text -> Int in
                let number = Int(text)
                if number != nil {
                    return number!
                } else {
                    return -1
                }
            }
            .map {
                self.tree.contains($0)
            }
            .assign(to: \.contains, on: self)
            .store(in: &anyCancellables)
        
        $removeText
            .map { text -> Int in
                let number = Int(text)
                if number != nil {
                    return number!
                } else {
                    return -1
                }
            }
            .sink { someValue in
                self.tree.remove(someValue)
            }
            .store(in: &anyCancellables)
    }
    
    func insert(_ value: String) {
        guard let number = Int(value) else {
            return
        }
        
        self.tree.insert(number)
    }
    
}

struct AVLTreeView: View {
    @StateObject var viewModel = AVLTreeViewModel()
    
    @State var removeText = ""
    @State var insertText = ""
    
    var body: some View {
        VStack(spacing: 20) {
            if viewModel.tree.root != nil {
                AVLTreeDiagram(tree: viewModel.tree.root!) { value, height in
                    ZStack(alignment: .bottomTrailing) {
                        Text("\(value)")
                                .font(.caption2)
                                .foregroundColor(.primary)
                                .padding()
                                .background(Circle().foregroundColor(.green))
                        
                        Text("\(height)")
                            .alignmentGuide(.trailing, computeValue: { -$0.width })
                    }
                    
                }
                .animation(.easeInOut)
            }
            

            HStack {
                TextField("请输入要删除的数字", text: $removeText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("确定") {
                    viewModel.removeText = removeText
                }
            }
            .padding(.horizontal, 10)
            
            HStack {
                TextField("请输入要插入的数字", text: $insertText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("确定") {
                    viewModel.insert(insertText)
                }

            }
            .padding(.horizontal, 10)

            Spacer()
        }
    }
}

struct AVLTreeDiagram<A, V: View>: View {
    let tree: AVLNode<A>
    let node: (A, Int) -> V
    
    typealias Key = CollectDict<String, Anchor<CGPoint>>
    
    var children: [AVLNode<A>] {
        var result: [AVLNode<A>] = []
        
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
            node(tree.value, tree.height)
                .anchorPreference(key: Key.self, value: .center, transform: {
                    [self.tree.id: $0]
                })

            HStack(alignment: .top, spacing: 10) {
                ForEach(([tree.left] + [tree.right]).compactMap { $0 }) { child in
                    AVLTreeDiagram(tree: child, node: self.node)
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

struct AVLTreeView_Previews: PreviewProvider {
    static var previews: some View {
        AVLTreeView()
    }
}
