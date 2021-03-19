//
//  LinkedListView:.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/18.
//

import SwiftUI
import Combine

class LinkedListViewModel: ObservableObject {
    @Published var nodes: [Node<Int>] = []
    
    @Published var linkedList = LinkedList<Int>()
    
    @Published var startValue: Int?
    
    @Published var sliceValues: [Int]?
    
    var anyCancellables: Set<AnyCancellable> = []
    
    init() {
        $linkedList
            .delay(for: .seconds(0.1), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.nodes = self?.linkedList.nodes ?? []
            }
            .store(in: &anyCancellables)
    }
    
    func push() {
        linkedList.push(3)
        linkedList.push(2)
        linkedList.push(1)
    }
    
    func append() {
        linkedList.append(4)
    }
    
    func insert() {
        let node = linkedList.node(at: 0)
        guard let n = node else {
            linkedList.push(100)
            return
        }
        _ = linkedList.insert(100, after: n)
    }
    
    func pop() {
        _ = linkedList.pop()
    }
    
    func removeLast() {
        _ = linkedList.removeLast()
    }
    
    func removeAfter() {
        let node = linkedList.node(at: 1)
        if node != nil {
            _ = linkedList.remove(after: node!)
        }
    }
    
    func startIndex() {
        self.startValue = linkedList[linkedList.startIndex]
    }
    
    func prefix3() {
        self.sliceValues = Array(linkedList.prefix(3))
    }
}

struct LinkedListView: View {
    @StateObject var viewModel = LinkedListViewModel()

    var body: some View {
        VStack(spacing: 20) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<self.viewModel.nodes.count, id: \.self) { index in
                        NodeView(node: self.viewModel.nodes[index])
                    }
                }
            }
        
            Button("push") {
                viewModel.push()
            }
            Button("append") {
                viewModel.append()
            }
            Button("insert") {
                viewModel.insert()
            }
            Button("pop") {
                viewModel.pop()
            }
            Button("removeLast") {
                viewModel.removeLast()
            }
            Button("removeAfter") {
                viewModel.removeAfter()
            }
            VStack {
                Button("startIndex") {
                    viewModel.startIndex()
                }
                Text("\(viewModel.startValue ?? 0)")
            }
            VStack {
                Button("prefix3") {
                    viewModel.prefix3()
                }
                Text("\(viewModel.sliceValues?.description ?? [].description)")
            }

        }
        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
        .navigationTitle("LinkedList")
    }
}

struct NodeView: View {
    let node: Node<Int>
    
    var body: some View {
        Text("\(node.value)")
            .foregroundColor(.primary)
            .padding()
            .background(Color.green)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
    }
}

struct LinkArrow: View {
    var body: some View {
        HStack(spacing: 0) {
            Color.primary
                .frame(width: 20, height: 2)
            Image(systemName: "arrowtriangle.right.fill")
                .foregroundColor(.primary)
                .imageScale(.small)
                .scaledToFill()
        }
    }
}

struct LinkedListView_Previews: PreviewProvider {
    static var previews: some View {
        LinkedListView()
    }
}
