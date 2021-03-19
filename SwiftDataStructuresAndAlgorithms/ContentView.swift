//
//  ContentView.swift
//  SwiftDataStructuresAndAlgorithms
//
//  Created by MC on 2021/3/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List { 
                NavigationLink(
                    destination: LinkedListView(),
                    label: {
                        Text("LinkedList")
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
