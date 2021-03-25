//
//  TrieView.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/25.
//

import SwiftUI

import Combine

class TrieViewModel: ObservableObject {
    @Published var tree = Trie<String>()
    
    @Published var inputText = ""
    
    @Published var contains = false
    
    @Published var removeText = ""
    
    var anyCancellables = Set<AnyCancellable>()
    
    init() {
        tree.insert("cute")
        tree.insert("cat")
        tree.insert("contains")
        tree.insert("com")
        
        $inputText
            .map {
                self.tree.contains($0)
            }
            .assign(to: \.contains, on: self)
            .store(in: &anyCancellables)
        
        $removeText
            .sink { someValue in
                self.tree.remove(someValue)
            }
            .store(in: &anyCancellables)
    }
    
    func insert(_ value: String) {
        self.tree.insert(value)
    }
    
}

struct TrieView: View {
    @StateObject var viewModel = TrieViewModel()
    
    @State var removeText = ""
    @State var insertText = ""
    
    var body: some View {
        VStack(spacing: 20) {
            TrieDiagram(tree: viewModel.tree.root) { value in
                ZStack(alignment: .bottomTrailing) {
                    Text("\(String(value))")
                            .font(.caption2)
                            .foregroundColor(.primary)
                            .padding()
                            .background(Circle().foregroundColor(.green))

                }
                
            }
            .animation(.easeInOut)
            
            HStack {
                TextField("请输入要查询的字符串", text: $viewModel.inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                Text(viewModel.contains ? "存在" : "不存在")
                    .foregroundColor(.red)
            }
            .padding(.horizontal, 10)

            HStack {
                TextField("请输入要删除的字符串", text: $removeText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("确定") {
                    viewModel.removeText = removeText
                }
            }
            .padding(.horizontal, 10)
            
            HStack {
                TextField("请输入要插入的字符串", text: $insertText)
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

struct TrieDiagram<A: Hashable, V: View>: View {
    let tree: TrieNode<A>
    let node: (A) -> V
    
    typealias Key = CollectDict<String, Anchor<CGPoint>>

    
    var children: [TrieNode<A>] {
        var result: [TrieNode<A>] = []
        
        for (_, v) in tree.children {
            result.append(v)
        }
        
        return result
    }

    var body: some View {
        VStack(spacing: 10) {
            if tree.key == nil {
                Text("root")
                    .font(.caption2)
                    .foregroundColor(.primary)
                    .padding()
                    .background(Circle().foregroundColor(.green))
                    .anchorPreference(key: Key.self, value: .center, transform: {
                        [self.tree.id: $0]
                    })
            } else {
                node(tree.key!)
                    .anchorPreference(key: Key.self, value: .center, transform: {
                        [self.tree.id: $0]
                    })
            }
            

            HStack(alignment: .top, spacing: 10) {
                ForEach(children) { child in
                    TrieDiagram(tree: child, node: self.node)
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

struct TrieView_Previews: PreviewProvider {
    static var previews: some View {
        TrieView()
    }
}
