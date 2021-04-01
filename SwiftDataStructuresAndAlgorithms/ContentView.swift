//
//  ContentView.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/18.
//

import SwiftUI

extension View {
    func toAnyView() -> AnyView {
        AnyView(self)
    }
}

struct ContentView: View {
    @State var views: [String: AnyView] = ["LinkedList": LinkedListView().toAnyView(),
                                        "Stack": StackView().toAnyView(),
                                        "Queue": QueueView().toAnyView(),
                                        "Tree": TreeView().toAnyView(),
                                        "BinaryTree": BinaryTreeView().toAnyView(),
                                        "BinarySearchTree": BinarySearchTreeView().toAnyView(),
                                        "AVLTree": AVLTreeView().toAnyView(),
                                        "Trie": TrieView().toAnyView(),
                                        "BinarySearch": BinarySearchView().toAnyView(),
                                        "Heap": HeapView().toAnyView(),
                                        "Sort": SortView().toAnyView()]
    
    var body: some View {
        NavigationView {
            List(Array(views.keys), id: \.self) { key in
                NavigationLink(
                    destination: views[key],
                    label: {
                        Text("\(key)")
                    })
            }

            .navigationTitle("Swift")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
