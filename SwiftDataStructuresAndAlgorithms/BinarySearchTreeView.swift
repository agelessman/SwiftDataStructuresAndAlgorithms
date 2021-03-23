//
//  BinarySearchTreeView.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/23.
//

import SwiftUI
import Combine

class BinarySearchTreeViewModel: ObservableObject {
    @Published var tree = BinarySearchTree<Int>()
    
    @Published var nodes: [BinaryNode<Int>] = []
    
    @Published var inputText = ""
    
    @Published var contains = false
    
    @Published var removeText = ""
    
    var anyCancellables = Set<AnyCancellable>()
    
    init() {
        tree.insert(50)
        tree.insert(25)

        tree.insert(12)
        tree.insert(10)
        tree.insert(17)
        tree.insert(37)
        tree.insert(32)
        tree.insert(45)
        tree.insert(27)
        tree.insert(33)
        tree.insert(75)
        tree.insert(63)
        tree.insert(87)
        
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

struct BinarySearchTreeView: View {
    @StateObject var viewModel = BinarySearchTreeViewModel()
    
    @State var removeText = ""
    @State var insertText = ""
    
    var body: some View {
        VStack(spacing: 20) {
            if viewModel.tree.root != nil {
                BinaryDiagram(tree: viewModel.tree.root!) { value in
                    Text("\(value)")
                        .font(.caption2)
                        .foregroundColor(.primary)
                        .padding()
                        .background(Circle().foregroundColor(.green))
                }
                .animation(.easeInOut)
            }
            
            HStack {
                TextField("请输入要查询的数字", text: $viewModel.inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                Text(viewModel.contains ? "存在" : "不存在")
                    .foregroundColor(.red)
            }
            .padding(.horizontal, 10)

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


struct BinarySearchTreeView_Previews: PreviewProvider {
    static var previews: some View {
        BinarySearchTreeView()
    }
}
